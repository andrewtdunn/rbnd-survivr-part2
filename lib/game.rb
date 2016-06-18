class Game
    attr_reader :tribes

    def initialize(*tribes)
        @tribes = []
        tribes.each do |tribe|
            @tribes << tribe
        end
    end

    def add_tribe(tribe)
        @tribes << tribe
    end

    def immunity_challenge
        @tribes[rand(0..1)]
    end

    def individual_immunity_challenge
        random_num = rand(0..@tribes[0].members.length-1)
        @tribes[0].members[random_num]
    end

    def clear_tribes
        @tribes.clear
    end

    def merge(tribe_name)
        new_members = [];
        @tribes.each do |tribe|
            tribe.members.each do |member|
                new_members << member
            end
        end
        Tribe.new({name:tribe_name, members: new_members})
    end
end