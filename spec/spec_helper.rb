require("rspec")
require("pg")
require("doctor")
require("patient")

DB = PG.connect({:dbdoctor_name => "doctor_office_test"})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM doctors *;")
    DB.exec("DELETE FROM patients *;")
  end
end
