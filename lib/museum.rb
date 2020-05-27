class Museum
  attr_reader :name, :exhibits, :patrons

  def initialize(name)
    @name = name
    @exhibits = []
    @patrons = []
  end

  def add_exhibit(exhibit)
    @exhibits << exhibit
  end

  def recommend_exhibits(patron)
    @exhibits.find_all { |exhibit| patron.interests.include?(exhibit.name) }
  end

  def admit(patron)
    @patrons << patron
  end

  def patrons_by_exhibit_interest
    patrons_by_exhibit_interest = Hash.new { |h, k| h[k] = [] }
    @exhibits.each do |exhibit|
      @patrons.each do |patron|
        if patron.interests.include?(exhibit.name)
          patrons_by_exhibit_interest[exhibit] << patron
        else
          patrons_by_exhibit_interest[exhibit]
        end
      end
    end
    patrons_by_exhibit_interest
  end

  def ticket_lottery_contestants(exhibit)
    @patrons.find_all do |patron|
      patron.interests.include?(exhibit.name) && patron.spending_money < exhibit.cost
    end
  end

  def draw_lottery_winner(exhibit)
    if ticket_lottery_contestants(exhibit).sample.nil?
      nil
    else
      ticket_lottery_contestants(exhibit).sample.name
    end
    #require'pry'; binding.pry
  end
end
