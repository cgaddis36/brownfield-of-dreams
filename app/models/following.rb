class Following
  attr_reader :name, :url
  
  def initialize(attributes)
    @name = attributes[:login]
    @url = attributes[:html_url]
  end

  def database?
    if User.where(url: self.url).empty?
      false
    else
      true
    end
  end
end
