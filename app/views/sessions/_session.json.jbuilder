json.extract! current_user, :phone
json.token @payload[:token]
json.exp Time.at(@payload[:exp])
