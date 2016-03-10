module PrintPersonJob
  @queue = :default

  def self.perform
    Person.all.each { |e| puts e.name }
  end
end
