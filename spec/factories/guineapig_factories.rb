FactoryGirl.define do
  factory :guineapig do  
        
    trait :paris do
      address "Paris, France"
    end
    
    trait :with_pic do
      picture "http://www.blankdots.com/img/github-32x32.png"
    end
    
    trait :invalid do
      address "home"
    end
    
    name    "Guinea Pig"
    address "Toulon, France"
    
    factory :guineapig_paris,    :traits => [:paris]
    factory :guineapig_with_pic, :traits => [:with_pic]
    factory :invalid_guineapig,  :traits => [:invalid]
  end
end