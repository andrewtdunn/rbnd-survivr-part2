class Tribe
    attr_reader :name, :members

    def initialize(obj)
        @name = obj[:name]
        @members = obj[:members]
        puts @name + " tribe created"
    end

    def tribal_council(*obj)
        unless obj[0].nil?
            immune = obj[0][:immune]
            @members.reject! { |member| member == immune}
        end
        rand_num = @members.length-1 > 0 ?rand(0...@members.length-1):0
        deleted = @members[rand_num]
        @members.slice!(rand_num)
        unless obj[0].nil?
            @members << immune
        end
        deleted
    end

    def format_members
        member_list = ""
        @members.each.with_index do |member, index|
            member_list = member_list +  member.to_s_with_color
            if member != @members.last
                member_list +=  ", "
            end
        end
        member_list
    end

    def to_s
        @name
    end

end