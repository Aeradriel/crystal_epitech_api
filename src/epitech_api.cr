require "http/client"
require "json"
require "./epitech_api/*"

module EpitechApi
  BASE_URL = "https://intra.epitech.eu"
  SIGN_IN_PATH = { method: "post", path: "/login" }

  @@access_token : String?

  def self.access_token
    @@access_token
  end

  def self.sign_in(login : String, password : String , remember_me : String = "on")
    response = EpitechApi.request(SIGN_IN_PATH, login: login, password: password, remember_me: remember_me)
    json = JSON.parse(response.body)
    if json.["access_token"]?
      @@access_token = JSON.parse(response.body)["access_token"].to_s
    else
      nil
    end
  end

  def self.request(route : NamedTuple(method: String, path: String), **args)
    url = BASE_URL + route[:path] + "?format=json"
    url += "&access_token=#{@@access_token}" if @@access_token
    if route[:method] == "post"
      args_str = self.named_tuple_to_args(args)
      HTTP::Client.post_form(url, args_str)
    else
      HTTP::Client.get(url)
    end
  end

  def self.named_tuple_to_args(tuple : NamedTuple)
    args = ""
    tuple.each do |k, v|
      args += "#{k}=#{v}&"
    end
    args
  end
end
