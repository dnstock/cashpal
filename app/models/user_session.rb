class UserSession < Authlogic::Session::Base
  # if login invalid, won't say which field is wrong
  # just: Login/Password combination is not valid
  generalize_credentials_error_messages true
end