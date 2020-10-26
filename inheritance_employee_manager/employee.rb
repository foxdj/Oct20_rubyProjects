

class Employee
    attr_reader :name, :title, :salary
    attr_accessor :boss

    def initialize(name, title, salary, boss = nil)
        @name, @title, @salary = name, title, salary
        self.boss = boss
    end

    def boss=(boss)
        @boss = boss
        boss.add_employee(self) unless boss.nil?
        boss
    end

    def bonus(multiplier)
        self.salary * multiplier
    end
end



class Manager < Employee
    attr_reader :employees

    def initialize(name, salary, title, boss = nil)
        super(name, salary, title, boss)
        @employees = []
    end

    def add_employee(subordinate)
        @employees << subordinate
        subordinate
    end
    
    def bonus(multiplier)
        self.total_subsalary * multiplier
    end

    protected

    def total_subsalary
        subsalary = 0
        @employees.each do |employee|
            if employee.is_a?(Manager)
                subsalary += employee.salary + employee.total_subsalary
            else
                subsalary += employee.salary
            end
        end

        subsalary
    end

end