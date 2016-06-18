class Jury
    attr_accessor :members

    def initialize
        @members  =[]
    end

    def add_member(member)
        @members << member
    end

    def cast_votes(votes)
        votes_obj = { votes[0] => 0, votes[1] => 0}
        @members.each do |member|
            rand_num = rand(0..1)
            vote = votes[rand_num]
            puts member.to_s_with_color + " casts their vote for " + vote.to_s_with_color + "."
            votes_obj[vote] += 1
        end
        votes_obj
    end

    def report_votes(votes_obj)
        votes_obj.each do |key, value|
            puts key.to_s_with_color + " received " + value.to_s + " votes."
        end
    end

    def announce_winner(votes_obj)
        winner = votes_obj.max_by {|k,v| v}[0]
        puts ""
        puts "The winner is " + winner.to_s_with_color + "!!"
        winner
    end
end