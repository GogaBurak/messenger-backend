json.extract! user, :phone
json.token @payload[:token]
json.exp Time.at(@payload[:exp])
