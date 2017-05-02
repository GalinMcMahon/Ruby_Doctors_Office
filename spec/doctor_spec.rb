require('rspec')
require('pg')
require('doctor')

DB = PG.connect({:dbname => 'doctor_office_test'})


RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM doctors *;")
  end
end

describe(Doctor) do
  describe(".all") do
    it("starts off with no doctors") do
      expect(Doctor.all()).to(eq([]))
    end
  end

  describe("#doctor_name") do
    it("tells you its doctor_name") do
      test_doctor = Doctor.new({:doctor_name => "Dr. Jones", :id => nil})
      expect(test_doctor.doctor_name()).to(eq("Dr. Jones"))
    end
  end

  describe("#id") do
    it("sets its ID when you save it") do
      test_doctor = Doctor.new({:doctor_name => "Dr. Jones", :id => nil})
      test_doctor.save()
      expect(test_doctor.id()).to(be_an_instance_of(Fixnum))
    end
  end
  #
  # describe("#save") do
  #   it("lets you save doctors to the database") do
  #     doctor = doctor.new({:doctor_name => "Dr. Jones", :id => nil})
  #     doctor.save()
  #     expect(doctor.all()).to(eq([doctor]))
  #   end
  # end
  #
  # describe("#==") do
  #   it("is the same doctor if it has the same doctor_name") do
  #     doctor1 = doctor.new({:doctor_name => "Dr. Jones", :id => nil})
  #     doctor2 = doctor.new({:doctor_name => "Dr. Jones", :id => nil})
  #     expect(doctor1).to(eq(doctor2))
  #   end
  # end
end
