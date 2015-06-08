class Flexiload < ActiveRecord::Base
  self.inheritance_column = nil

  TYPE_PREPAID = 0
  TYPE_POSTPAID = 1

  STATUS_PROCESSING = 'Processing'
  STATUS_SUCCESS = 'Success'
  STATUS_FAILED = 'Failed'

  validates :type, :amount, presence: true
  validates :phone, presence: true

  before_create :send_flexiload_request

  def humanize_type
    case type
      when TYPE_PREPAID
        'Prepaid'
      when TYPE_POSTPAID
        'Postpaid'
      else
        'N/A'
    end
  end

  def status
    _status = super
    begin
      if _status == STATUS_PROCESSING
        response = HTTParty.get("http://new.turbotopup.com/index.php?_route=api/stsf/#{flmcs_order_id}")
        json_data = JSON.parse(Base64.decode64(response.body))
        update_attributes({
                              status: json_data['status'],
                              flmcs_transaction_id: json_data['transactionid']
                          })
        json_data['status']
      else
        _status
      end
    rescue
      _status
    end
  end

  def self.type_options
    [
        ['Prepaid', TYPE_PREPAID],
        ['Postpaid', TYPE_POSTPAID]
    ]
  end

  private
  def send_flexiload_request
    begin
      params = {
          user: 'Test_Atik',
          key: 'cch4drge2201wwrc21fayi4j1j7otnovpvqsdwx6',
          phone: phone,
          type: type.to_s,
          amount: amount.to_s
      }.to_json
      request = Base64.strict_encode64(params)
      response = HTTParty.get("http://new.turbotopup.com/index.php?_route=api/mr/#{request}")

      if response.body.to_i == -1
        errors[:base] << 'something went wrong in api end'
        return false
      elsif response.body.to_i == 0
        errors[:phone] << response.body
        return false
      else
        self.flmcs_order_id = response.body
        self.status = STATUS_PROCESSING
        return true
      end
    rescue Exception => ex
      p ex.message
      errors[:base] << 'something went wrong in api end'
      return false
    end
  end
end
