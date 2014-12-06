require 'faker'

ActionMailer::Base.perform_deliveries = false


uc = User.count
sc = Story.count


10.times do |i|
  
  puts "ADDING USER"
  
  u = User.new(:login => "sample#{uc + i}", :email => "sample#{uc + i}@onestoryroad.com", :password => "enternow", :password_confirmation => "enternow", :city => Faker::Address.city, :agreed => true)

  if u.save
  
    puts "USER SAVED"
    
    4.times do |j|
      
      puts "ADDING STORY"
      
      s = u.stories.build(:title => Faker::Lorem.sentence((3..10).sort_by{ rand() }.first), :location => Faker::Address.city, :tag_list => Faker::Lorem.words((3..10).sort_by{ rand() }.first), :published => true)
      
      if s.save
        
        2.times do |k|
        
          puts "ADDING PARAGRAPH"
          
          pg = s.paragraphs.build(:body => "paragraph body #{k}")
          pg.save
          
        end
          
      end
      
    end  
 
  else
    
    puts "USER *NOT* SAVED" 
    puts u.errors.to_a.join('\n')
     
  end
  
end

puts "DONE!"