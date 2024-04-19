
/**
 * Q4 - Assume all method calls work fine. Fix the memory leak issue in below method
 * void Game::addItemToPlayer(const std::string &recipient, uint16_t itemId)
 * {
 *     Player *player = g_game.getPlayerByName(recipient);
 *     if (!player)
 *     {
 *         player = new Player(nullptr);
 *         if (!IOLoginData::loadPlayerByName(player, recipient))
 *         {
 *             return;
 *         }
 *     }
 *
 *     Item *item = Item::CreateItem(itemId);
 *     if (!item)
 *     {
 *         return;
 *     }
 *
 *     g_game.internalAddItem(player->getInbox(), item, INDEX_WHEREEVER, FLAG_NOLIMIT);
 *
 *     if (player->isOffline())
 *     {
 *         IOLoginData::savePlayer(player);
 *     }
 * }
 */

/**
 * Answer:
 * The main issue here is that we are creating new Player object when we failed to `getPlayerByName`,
 * but didn't handle the deallocation when that happen. To solve this I created a flag to indicate if
 * a new Player object is created, and make sure `delete player;` is called before function end.
 */
void Game::addItemToPlayer(const std::string &recipient, uint16_t itemId)
{
    Player *player = g_game.getPlayerByName(recipient);
    bool playerCreated = false;
    if (!player)
    {
        player = new Player(nullptr);
        playerCreated = true;
        if (!IOLoginData::loadPlayerByName(player, recipient))
        {
            delete player;
            return;
        }
    }

    Item *item = Item::CreateItem(itemId);
    if (!item)
    {
        if (playerCreated)
        {
            delete player;
        }
        return;
    }

    g_game.internalAddItem(player->getInbox(), item, INDEX_WHEREEVER, FLAG_NOLIMIT);

    if (player->isOffline())
    {
        IOLoginData::savePlayer(player);
    }

    if (playerCreated)
    {
        delete player;
    }
}