class Employee
  attr_reader :salary
  def initialize(name, title, salary, boss)
    @name = name
    @title = title
    @salary = salary
    @boss = boss
    assign_manager
  end

  def bonus(multiplier)
    @salary * multiplier
  end

  def assign_manager
    @boss.employees << self if @boss
  end

end

class Manager < Employee
  attr_accessor :employees
  def initialize(name, title, salary, boss)
    super
    @employees = []
  end

  def bonus(multiplier)
    base.inject(:+) * multiplier
  end

  def base
    base =  @employees.map do |employee|
      if employee.is_a?(Manager)
        subordinates = employee.base
        [employee.salary] + subordinates
      else
        [employee.salary]
      end
    end
    base.flatten
  end


end

if __FILE__ == $PROGRAM_NAME
  ned = Manager.new("ned", "founder", 1000000, nil)
  darren = Manager.new("darren","TA manager",78000,ned)
  shawna = Employee.new("shawna","TA",12000,darren)
  david = Employee.new("david","TA",10000,darren)

  p ned.bonus(5) # => 500_000
  p darren.bonus(4) # => 88_000
  p david.bonus(3) # => 30_000
end
