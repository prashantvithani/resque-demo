module PrintRandomJob
  @queue = :default

  def self.perform
    10000.times { |n| puts 'This is n' }
  end
end
