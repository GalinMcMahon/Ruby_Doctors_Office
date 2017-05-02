class Patient
  attr_reader(:patient_name, :doctor_id, :id, :birthday)
  @@all_patients = []

  define_method(:initialize) do |attributes|
    @patient_name = attributes.fetch(:patient_name)
    @doctor_id = attributes.fetch(:doctor_id)
    @id = attributes.fetch(:id)
    @birthday = attributes.fetch(:birthday)
  end

  define_singleton_method(:all) do
    returned_patients = DB.exec("SELECT * FROM patients;")
    patients = []
    returned_patients.each() do |patient|
      patient_name = patient.fetch("patient_name")
      doctor_id = patient.fetch("doctor_id").to_i() # The information comes out of the database as a string.
      patients.push(Patient.new({:patient_name => patient_name, :doctor_id => doctor_id, :id => nil, :birthday => "1975-01-01"}))
    end
    patients
  end

  define_method(:save) do
    DB.exec("INSERT INTO patients (patient_name, doctor_id, birthday) VALUES ('#{@patient_name}', #{@doctor_id}, '#{@birthday}');")
  end

  define_method(:==) do |another_patient|
    self.patient_name().==(another_patient.patient_name()).&(self.doctor_id().==(another_patient.doctor_id()))
  end
end
