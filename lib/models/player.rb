old_logger = ActiveRecord::Base.logger
ActiveRecord::Base.logger = nil

class Player < ActiveRecord::Base

  has_many :battles
  has_many :enemies, through: :battles

  def initialize(args = {})
    args[:health] ||= 100
    args[:attack] ||= 25
    super
  end

  def get_random_enemy
    # Enemy.order("RANDOM()").first(1)[0]
    alive_enemy = Enemy.where("health > 0")
    if alive_enemy.length == 0
      win_game
    end
    alive_enemy.order("RANDOM()").first(1)[0]
  end

  def enter_battle
  	 enemy = get_random_enemy
  	 player_enemy_battle = Battle.create(player_id: self.id, enemy_id: enemy.id)
     player_enemy_battle.battlefield
  end

  def win_game
    puts "YOU HAVE DEFEATED ALL OF THE ENEMIES! YOU ARE THE HERO THE TALES SPOKE OF!! "
    puts "                          GAME OVER."
    puts "THANKS FOR PLAYING. LOVE TONY AND SEAN"
    #ASCII cat
    destroy_all
    exit
  end


end
