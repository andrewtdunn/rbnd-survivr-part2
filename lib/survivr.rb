require_relative "game"
require_relative "tribe"
require_relative "contestant"
require_relative "jury"

#After your tests pass, uncomment this code below
#=========================================================
# Create an array of twenty hopefuls to compete on the island of Borneo
@contestants = %w(carlos walter aparna trinh diego juliana poornima juha sofia julia fernando dena orit colt zhalisa farrin jarobi tip ali phife)
@contestants.map!{ |contestant| Contestant.new(contestant) }.shuffle!

# # # Create two new tribes with names
@coyopa = Tribe.new(name: "Pagong", members: @contestants.shift(10))
@hunapu = Tribe.new(name: "Tagi", members: @contestants.shift(10))

# # # Create a new game of Survivor
@borneo = Game.new(@coyopa, @hunapu)
#=========================================================


#This is where you will write your code for the three phases
def print_phase_header(phase)
    puts ""
    puts "* " * 50
    puts "Phase " + phase.to_s
    puts "* " * 50
end

def print_challenge_header(phase, challenge)
    puts "- " * 25
    puts "Phase " + phase.to_s + ", Challenge: " + challenge.to_s
    puts "- " * 25
end

def phase_one
    print_phase_header(1)
    voted_off = []
    8.times do |i|
        print_challenge_header(1,i+1)
        losing_tribe = @borneo.immunity_challenge()
        puts "losing tribe: " + losing_tribe.to_s
        loser = losing_tribe.tribal_council
        voted_off << loser
        puts loser.to_s_with_color + " has been voted off " + losing_tribe.to_s
        puts  "Pagong has " + @coyopa.members.length.to_s + " members"
        puts  "Tagi has " + @hunapu.members.length.to_s + " members"
    end
end

def phase_two
    @borneo.clear_tribes()
    @borneo.add_tribe(@merge_tribe)
    print_phase_header(2)
    voted_off = []
    3.times do |i|
        print_challenge_header(2,i+1)
        immune_member = @borneo.individual_immunity_challenge()
        puts immune_member.to_s_with_color + " is immune"
        loser = @merge_tribe.tribal_council({immune: immune_member})
        puts loser.to_s_with_color + " has been voted off " + @merge_tribe.to_s
        puts "Remaining tribemates of " + @merge_tribe.to_s + " are: " + @merge_tribe.format_members + "."
        voted_off << loser
    end
end

def phase_three
    print_phase_header(3)
    voted_off = []
    7.times do |i|
        print_challenge_header(3,i+1)
        immune_member = @borneo.individual_immunity_challenge()
        puts immune_member.to_s_with_color + " won the immunity challenge and is safe from elimination."
        voted_off_member =  @merge_tribe.tribal_council({immune: immune_member})
        puts voted_off_member.to_s_with_color + " was voted off the island."
        @jury.members << voted_off_member
        puts "Remaining tribemates of " + @merge_tribe.to_s + " are: " + @merge_tribe.format_members + "."
        puts voted_off_member.to_s_with_color  + " is member " + i.to_s + " of the jury."
        puts ""
        puts ""
    end
end
#

# If all the tests pass, the code below should run the entire simulation!!
#=========================================================
phase_one #8 eliminations
@merge_tribe = @borneo.merge("Cello") # After 8 eliminations, merge the two tribes together
phase_two #3 more eliminations
@jury = Jury.new
phase_three #7 elminiations become jury members
finalists = @merge_tribe.members #set finalists
vote_results = @jury.cast_votes(finalists) #Jury members report votes
@jury.report_votes(vote_results) #Jury announces their votes
@jury.announce_winner(vote_results) #Jury announces final winner
