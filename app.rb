require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/patient")
require("./lib/doctor")
require('pg')

DB = PG.connect({:dbname => 'doctor_office_test'})

get("/") do
  @doctors = Doctor.all()
  # @patients = Patient.all()
  erb(:index)
end

get("/new_doctor") do
  erb(:doctor_form)
end

post("/new_doctor") do
  doctor_name = params.fetch("doctor_name")
  @doctor_name = params.fetch("doctor_name")
  doctor_specialty = params.fetch("specialty")

  # doctor_id = params.fetch(@id).to_i()
  doctor = Doctor.new({:doctor_name => doctor_name, :specialty => doctor_specialty, :id => nil})
  doctor.save()

  erb(:success)
end


#
# post("/patients") do
#   patient_name = params.fetch("patient_name") #patients table
#   # doctor_id = params.fetch("doctor_id").to_i() #patients table
#   # @doctor = doctor.find(doctor_id)
#   # @patient = patient.new({:patient_name => patient_name, :doctor_id => doctor_id})
#   # @patient.save()
#   # patient = patient.new(patient_name)
#   # patient.save()
#   erb(:output)
# end
