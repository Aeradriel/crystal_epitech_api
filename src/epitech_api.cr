require "http/client"
require "json"
require "./epitech_api/*"

module EpitechApi
  # Base url for all requests
  BASE_URL = "https://intra.epitech.eu"
  # Path to sign in
  SIGN_IN_PATH = { method: "post", path: "/login" }

  @@access_token : String?

  # Getter for the access token
  def self.access_token
    @@access_token
  end

  # Sign the user in with the credentials passed as arguments.
  # If the sign in is a success, @@access_token is populated.
  #
  #```
  # EpitechApi.sign_in("roche_t", "fakepass", "on") # : String
  #```
  def self.sign_in(login : String, password : String , remember_me : String = "on")
    json = EpitechApi.request(SIGN_IN_PATH, login: login, password: password, remember_me: remember_me)
    if json.["access_token"]?
      @@access_token = json["access_token"].to_s
    else
      nil
    end
  end

  # Send a request depending on the given route.
  # You can pass arguments that will be submitted in POST requests as named tuple.
  #
  #```
  # EpitechApi.request(SIGN_IN_PATH, login: login, password: password, remember_me: remember_me) # : JSON::Any
  #```
  def self.request(route : NamedTuple(method: String, path: String), **args)
    url = BASE_URL + route[:path].gsub("//", "/") + "?format=json"
    url += "&access_token=#{@@access_token}" if @@access_token
    if route[:method] == "post"
      args_str = self.named_tuple_to_args(args)
      resp = HTTP::Client.post_form(url, args_str)
    else
      resp = HTTP::Client.get(url)
    end
    JSON.parse(resp.body) rescue {} of JSON::Any => JSON::Any
  end

  # Converts a named tuple into a string ready for being used in an HTTP::Request.
  #
  # ```
  # EpitechApi.named_tuple_to_args({name: "test"}) # => "?name=test"
  # ```
  def self.named_tuple_to_args(tuple : NamedTuple)
    args = ""
    tuple.each do |k, v|
      args += "#{k}=#{v}&"
    end
    args
  end
end
