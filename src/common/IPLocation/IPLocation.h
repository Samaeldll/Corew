/*
 * This file is part of the WarheadCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Affero General Public License as published by the
 * Free Software Foundation; either version 3 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "Define.h"
#include <string>
#include <vector>

struct IpLocationRecord
{
    IpLocationRecord() = default;
    IpLocationRecord(uint32 ipFrom, uint32 ipTo, std::string countryCode, std::string countryName)
        : IpFrom(ipFrom), IpTo(ipTo), CountryCode(std::move(countryCode)), CountryName(std::move(countryName)) { }

    uint32 IpFrom{ 0 };
    uint32 IpTo{ 0 };
    std::string CountryCode;
    std::string CountryName;
};

class WH_COMMON_API IpLocationStore
{
public:
    IpLocationStore() = default;
    ~IpLocationStore() = default;

    static IpLocationStore* Instance();

    void Load();
    IpLocationRecord const* GetLocationRecord(std::string const& ipAddress) const;

private:
    std::vector<IpLocationRecord> _ipLocationStore;
};

#define sIPLocation IpLocationStore::Instance()
