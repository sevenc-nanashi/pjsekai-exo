# frozen_string_literal: true
require "net/https"

class PSExo
  Response = Struct.new(:code, :body)

  def http_get(url)
    ENV["SSL_CERT_FILE"] = File.expand_path(__dir__ + "/cacert.pem") if ENV["OCRA_EXECUTABLE"]
    uri = URI(url)
    res = Net::HTTP.start(uri.host, 443, use_ssl: true, ca_file: ENV["SSL_CERT_FILE"]) do |http|
      req = Net::HTTP::Get.new(uri)
      http.request(req)
    end
    Response.new(res.code.to_i, res.body)
  end
end
