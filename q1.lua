-- Q1 - Fix or improve the implementation of the below methods
-- local function releaseStorage(player)
--     player:setStorageValue(1000, -1)
-- end

-- function onLogout(player)
--     if player:getStorageValue(1000) == 1 then
--         addEvent(releaseStorage, 1000, player)
--     end
--     return true
-- end


-- Answer:
-- 1. Added the `key` param to `releaseStorage` so it can be more generic to release storage with a different key
-- 2. Moved the storage value checking into `releaseStorage` to make the function more self-contained, 
--      improve readability of the function and easier to debug or change in the future
-- 3. Changed storage checking condition to >= 0, so storage is released whenever there's a positive value
-- 4. Remove `addEvent` as it really seems unnecessary in the given context
-- 5. Ideally we don't want to hardcode the storage key here, so I am assuming we added `loggedIn=1000` to the `PlayerStorageKeys`,
--      as it kind of make sense that we reset this flag value on player logout event.
local function releaseStorage(player, key)
    if player:getStorageValue(key) >= 0 then
        player:setStorageValue(key, -1)
    end
end

function onLogout(player)
    releaseStorage(player, PlayerStorageKeys.loggedIn)
    return true
end
