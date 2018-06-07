class Team < ActiveRecord::Base
  has_many :matches_a, class_name: 'Match', foreign_key: 'team_a'
  has_many :matches_b, class_name: 'Match', foreign_key: 'team_b'

  def matches
    Match.where("team_a = ? or team_b = ?", self.id, self.id)
  end

  def self.create_all
    return if Team.count == 24
    Team.create name:"Albania",api_name: "ALB", image: "http://img.uefa.com/imgml/2016/euro/teams/header/M/ALB.jpg"

    Team.create name:"Austria",api_name: "AUT",image: "http://img.uefa.com/imgml/2016/euro/teams/header/M/AUT.jpg"

    Team.create name:"Belgium",api_name: "BEL",image: "http://img.uefa.com/imgml/2016/euro/teams/header/M/BEL.jpg"

    Team.create name:"Croatia",api_name: "CRO",image: "http://img.uefa.com/imgml/2016/euro/teams/header/M/CRO.jpg"

    Team.create name:"Czech Republic",api_name: "CZE",image: "http://img.uefa.com/imgml/2016/euro/teams/header/M/CZE.jpg"

    Team.create name:"England",api_name: "ENG",image: "http://img.uefa.com/imgml/2016/euro/teams/header/M/ENG.jpg"

    Team.create name:"Spain",api_name: "ESP",image: "http://img.uefa.com/imgml/2016/euro/teams/header/M/ESP.jpg"

    Team.create name:"France",api_name: "FRA",image: "http://img.uefa.com/imgml/2016/euro/teams/header/M/FRA.jpg"

    Team.create name:"Germany",api_name: "GER",image: "http://img.uefa.com/imgml/2016/euro/teams/header/M/GER.jpg"

    Team.create name:"Hungary",api_name: "HUN",image: "http://img.uefa.com/imgml/2016/euro/teams/header/M/HUN.jpg"

    Team.create name:"Republic of Ireland",api_name: "IRL",image: "http://img.uefa.com/imgml/2016/euro/teams/header/M/IRL.jpg"

    Team.create name:"Iceland",api_name: "ISL",image: "http://img.uefa.com/imgml/2016/euro/teams/header/M/ISL.jpg"

    Team.create name:"Italy",api_name: "ITA",image: "http://img.uefa.com/imgml/2016/euro/teams/header/M/ITA.jpg"

    Team.create name:"Northern Ireland",api_name: "NIR",image: "http://img.uefa.com/imgml/2016/euro/teams/header/M/NIR.jpg"

    Team.create name:"Poland",api_name: "POL",image: "http://img.uefa.com/imgml/2016/euro/teams/header/M/POL.jpg"

    Team.create name:"Portugal",api_name: "POR",image: "http://img.uefa.com/imgml/2016/euro/teams/header/M/POR.jpg"

    Team.create name:"Romania",api_name: "ROU",image: "http://img.uefa.com/imgml/2016/euro/teams/header/M/ROU.jpg"

    Team.create name:"Russia",api_name: "RUS",image: "http://img.uefa.com/imgml/2016/euro/teams/header/M/RUS.jpg"

    Team.create name:"Switzerland",api_name: "SUI",image: "http://img.uefa.com/imgml/2016/euro/teams/header/M/SUI.jpg"

    Team.create name:"Slovakia",api_name: "SVK",image: "http://img.uefa.com/imgml/2016/euro/teams/header/M/SVK.jpg"

    Team.create name:"Sweden",api_name: "SWE",image: "http://img.uefa.com/imgml/2016/euro/teams/header/M/SWE.jpg"

    Team.create name:"Turkey",api_name: "TUR",image: "http://img.uefa.com/imgml/2016/euro/teams/header/M/TUR.jpg"

    Team.create name:"Ukraine",api_name: "UKR",image: "http://img.uefa.com/imgml/2016/euro/teams/header/M/UKR.jpg"

    Team.create name:"Wales",api_name: "WAL",image: "http://img.uefa.com/imgml/2016/euro/teams/header/M/WAL.jpg"

  end

end
