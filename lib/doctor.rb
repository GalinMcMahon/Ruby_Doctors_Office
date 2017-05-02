class Doctor
  attr_reader(:doctor_name, :id, :specialty)

  define_method(:initialize) do |attributes|
    @doctor_name = attributes.fetch(:doctor_name)
    @specialty = attributes.fetch(:specialty)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    returned_doctors = DB.exec("SELECT * FROM doctors;")
    doctors = []
    returned_doctors.each() do |doctor|
      id = doctor.fetch("id").to_i()
      doctor_name = doctor.fetch("doctor_name")
      specialty = doctor.fetch("specialty")
      doctors.push(Doctor.new({:doctor_name => doctor_name, :id => id, :specialty => specialty}))
    end
    doctors
  end

  define_method(:==) do |another_doctor|
    self.doctor_name().==(another_doctor.doctor_name()).&(self.id().==(another_doctor.id()))
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO doctors (doctor_name, specialty) VALUES ('#{@doctor_name}', '#{@specialty}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_singleton_method(:find) do |id|
    found_doctor = nil
    Doctor.all().each() do |doctor|
      if doctor.id().==(id)
        found_doctor = doctor
      end
    end
    found_doctor
  end

  define_method(:patients) do
    doctor_patients = []
    patients = DB.exec("SELECT * FROM patients WHERE doctor_id = #{self.id()};")
    patients.each() do |patient|
      patient_name = patient.fetch("patient_name")
      birthday = patient.fetch("birthday")
      id = patient.fetch("id").to_i()
      doctor_id = patient.fetch("doctor_id").to_i()
      doctor_patients.push(Patient.new({:patient_name => patient_name, :doctor_id => doctor_id, :id => nil, :birthday => birthday}))
    end
    doctor_patients
  end
end
