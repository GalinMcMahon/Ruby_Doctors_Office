class Doctor
  attr_reader(:doctor_name, :id)

  define_method(:initialize) do |attributes|
    @doctor_name = attributes.fetch(:doctor_name)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    returned_doctors = DB.exec("SELECT * FROM doctors;")
    doctors = []
    returned_doctors.each() do |doctor|
      doctor_name = doctor.fetch("doctor_name")
      id = doctor.fetch("id").to_i()
      doctors.push(doctor.new({:doctor_name => doctor_name, :id => id}))
    end
    doctors
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO doctors (doctor_name) VALUES ('#{@doctor_name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:==) do |another_doctor|
    self.doctor_name().==(another_doctor.doctor_name()).&(self.id().==(another_doctor.id()))
  end
end
