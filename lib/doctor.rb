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
      doctor_name = doctors.fetch("doctor_name")
      id = doctors.fetch("id").to_i()
      specialty = doctors.fetch("specialty")
      doctors.push(Doctor.new({:doctor_name => doctor_name, :id => id, :specialty => specialty}))
    end
    doctors
  end

  # define_method(:save) do
  #   result = DB.exec("INSERT INTO doctors (doctor_name, specialty) VALUES ('#{@doctor_name}', '#{@specialty}') RETURNING id;")
  #   @id = result.first().fetch("id").to_i()
  # end

  define_method(:==) do |another_doctor|
    self.doctor_name().==(another_doctor.doctor_name()).&(self.id().==(another_doctor.id()))
  end
end
