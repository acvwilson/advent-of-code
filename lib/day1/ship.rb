class Ship
  def fuel_requirement_for(mass)
    fuel_requirement_mass = simple_fuel_requirement(mass)
    fuel_requirement_total = fuel_requirement_mass

    until fuel_requirement_mass <= 0
      fuel_requirement_mass = simple_fuel_requirement(fuel_requirement_mass)
      fuel_requirement_total += fuel_requirement_mass
    end

    fuel_requirement_total
  end

  def sum_of_fuel_requirements(masses)
    masses.sum do |mass|
      fuel_requirement_for mass
    end
  end

private
  def simple_fuel_requirement(mass)
    fuel_requirement = mass / 3 - 2

    fuel_requirement < 0 ? 0 : fuel_requirement
  end
end
