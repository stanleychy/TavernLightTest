-- Q3 - Fix or improve the name and the implementation of the below method
-- function do_sth_with_PlayerParty(playerId, membername)
--     player = Player(playerId)
--     local party = player:getParty()

--     for k, v in pairs(party:getMembers()) do
--         if v == Player(membername) then
--             party:removeMember(Player(membername))
--         end
--     end
-- end

-- Answer:
-- 1. Base on the code I am assuming this function is for removing a memeber with the specified `memberName` from
--      the player's party, and I renamed the function accordingly
-- 2. Made `player` and `member` as local variables for faster access and avoid cluttering the global environment
-- 3. Iterate through the party member list and check if the specified member exists seem redundant so I removed it,
--      as I looked into the TFS source code `removeMember` has it's checking logic which already included such case
-- 4. Added variables validity checking to prevent null reference error, added logging corresponding to each validation
function removeMemberFromPlayerParty(playerId, memberName)
    local player = Player(playerId)
    local member = Player(memberName)
    if not player then
        print("Invalid playerId " .. playerId)
        return
    end

    if not member then
        print("Invalid memberName " .. memberName)
        return
    end

    local party = player:getParty()
    if not party then
        print("Failed to get player party")
        return
    end

    party:removeMember(member)
end
