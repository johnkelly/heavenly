ActionController::API.send :include, ActionController::StrongParameters
ActionController::API.send :include, ActionController::HttpAuthentication::Token::ControllerMethods
