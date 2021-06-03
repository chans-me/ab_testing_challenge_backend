class ApiBaseController < ApplicationController
  def ok result
    {json: {result: result}, status: Rack::Utils::SYMBOL_TO_STATUS_CODE[:ok]}
  end

  def bad_request message
    {json: {error: message},status: Rack::Utils::SYMBOL_TO_STATUS_CODE[:bad_request]}
  end

  def unauthorized_request message
    {json: {error: message}, status: Rack::Utils::SYMBOL_TO_STATUS_CODE[:unauthorized]}
  end

  def internal_error message
    {json: {error: message}, status: Rack::Utils::SYMBOL_TO_STATUS_CODE[:internal_server_error]}
  end
end