require 'open-uri'

unless User.exists?(name: 'Jesse Sessler', admin: true)
  User.create(name: 'Jesse Sessler',
              email: 'jesse.sessler@gmail.com',
              admin: true,
              zip_code: 10065,
              password: 'jessesessler',
              password_confirmation: 'jessesessler')
end

boroughs = {'X' => 'Bronx',
            'B' => 'Brooklyn',
            'M' => 'Manhattan',
            'Q' => 'Queens',
            'R' => 'Staten Island'}

courts = Crack::XML.parse(open("http://www.nycgovparks.org/bigapps/DPR_Basketball_001.xml"))
courts['basketball']['facility'].each do |c|
  Court.create(name: c['Name'],
               location: c['Location'],
               borough: boroughs[c['Prop_ID'][0]],
               num_courts: c['Num_of_Courts'].to_i,
               latitude: c['lat'].to_f,
               longitude: c['lon'].to_f)
end


