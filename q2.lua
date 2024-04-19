-- Q2 - Fix or improve the implementation of the below method
-- function printSmallGuildNames(memberCount)
--     -- this method is supposed to print names of all guilds that have less than memberCount max members
--     local selectGuildQuery = "SELECT name FROM guilds WHERE max_members < %d;"
--     local resultId = db.storeQuery(string.format(selectGuildQuery, memberCount))
--     local guildName = result.getString("name")
--     print(guildName)
-- end


-- Answer:
-- 1. Added backtick to SQL query to follow the best practice of avoiding naming errors
-- 2. Construct and pass the SQL query directly to `db.storeQuery` as there are no need for reusing the query
--      and that we can save some memory
-- 3. Added conditional statement and logging to show if the query found small guilds that meet the criteria
-- 4. Fixed the issue of missing iteration on query result to print all small guilds name
-- 5. Combined print guild name logic to one line and save the memory for storing the short lived guild name value
-- 6. Added `result.free(resultId)` to free up the memory after we finished the work
function printSmallGuildNames(memberCount)
    -- this method is supposed to print names of all guilds that have less than memberCount max members
    local resultId = db.storeQuery("SELECT `name` FROM `guilds` WHERE `max_members` < " .. memberCount)

    if not resultId then
        print("No small guild found.")
    else
		repeat
			print(result.getString("name"))
		until not result.next(resultId)
		result.free(resultId)
	end
end