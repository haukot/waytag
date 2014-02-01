class Api::ApplicationController < ApplicationController
  http_basic_authenticate_with name: "WtRFEf6g6owQofSTWLeg", password: "Etpd1BNhTcfmu3dKP1HT"

  respond_to :json
  layout false
end
