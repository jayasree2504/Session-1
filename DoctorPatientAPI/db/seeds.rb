# db/seeds.rb

# Seed Clinics
clinic_1 = Clinic.create!(
  name: "Downtown Health Clinic",
  address: "123 Main St, Downtown"
)

clinic_2 = Clinic.create!(
  name: "Eastside Medical Center",
  address: "456 East St, Eastside"
)

# Seed Doctors
doctor_1 = Doctor.create!(
  name: "Dr. Alice Green",
  specialization: "Cardiologist",
  clinic: clinic_1
)

doctor_2 = Doctor.create!(
  name: "Dr. Bob White",
  specialization: "General",
  clinic: clinic_1
)

doctor_3 = Doctor.create!(
  name: "Dr. Carol Black",
  specialization: "Dentist",
  clinic: clinic_2
)

doctor_4 = Doctor.create!(
  name: "Dr. Dave Blue",
  specialization: "Neurologist",
  clinic: clinic_2
)

# Seed Patients using Faker (Optional)
10.times do
  Patient.create!(
    name: Faker::Name.name,
    age: rand(18..80)
  )
end

# Seed Appointments
Appointment.create!(
  doctor: doctor_1,
  patient: Patient.first,
  appointment_date: 2.days.from_now
)

Appointment.create!(
  doctor: doctor_2,
  patient: Patient.second,
  appointment_date: 3.days.from_now
)

Appointment.create!(
  doctor: doctor_3,
  patient: Patient.third,
  appointment_date: 5.days.from_now
)

Appointment.create!(
  doctor: doctor_4,
  patient: Patient.fourth,
  appointment_date: 1.day.from_now
)
