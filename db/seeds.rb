# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

AlertDepartment.destroy_all
AlertUser.destroy_all
Url.destroy_all
KeyValue.destroy_all
Alert.destroy_all
Kind.destroy_all
Family.destroy_all
Severity.destroy_all
Department.destroy_all
User.destroy_all
Source.destroy_all

kind_security =       Kind.create(name: 'Security',       icon: 'fas fa-exclamation-triangle')
kind_compliance =     Kind.create(name: 'Compliance',     icon: 'fas fa-clipboard-check')
kind_informational =  Kind.create(name: 'Informational',  icon: 'fas fa-info-circle')

family_attack =         Family.create(name: 'Attack',         icon: 'fas fa-user-secret')
family_infrastructure = Family.create(name: 'Infrastructure', icon: 'fas fa-server')
family_networking =     Family.create(name: 'Networking',     icon: 'fas fa-wifi')
family_software =       Family.create(name: 'Software',       icon: 'fas fa-compact-disc')

severity_info =     Severity.create(name: 'Info',     order: 0, color: 'rgb(41, 70, 128)')
severity_low =      Severity.create(name: 'Low',      order: 1, color: 'rgb(0, 160, 60)')
severity_medium =   Severity.create(name: 'Medium',   order: 2, color: 'rgb(244, 207, 0)')
severity_high =     Severity.create(name: 'High',     order: 3, color: 'rgb(240, 140, 17)')
severity_critical = Severity.create(name: 'Critical', order: 4, color: 'rgb(199, 22, 30)')

department_it =           Department.create(name: 'IT')
department_development =  Department.create(name: 'Development')
department_operations =   Department.create(name: 'Operations')

user_lloydpick = User.create(name: 'Lloyd Pick')

source_aws_rds = Source.create(name: 'AWS RDS', icon: 'fab fa-amazon')

Alert.create!(
  name: 'Test Alert',
  finding: { some: 'data' }.to_json,
  finding_id: 'abcdef012345',
  kind: kind_compliance,
  family: family_infrastructure,
  severity_internal: severity_medium,
  severity_external: severity_critical,
  departments: [department_operations],
  users: [user_lloydpick],
  source: source_aws_rds,
  first_detected_at: Time.now.utc,
  urls: [Url.new(name: 'AWS Dashboard', url: 'https://docs.aws.amazon.com/lambda/latest/dg/current-supported-versions.html')],
  key_values: [KeyValue.new(key: 'region', value: 'eu-west-1')]
)
