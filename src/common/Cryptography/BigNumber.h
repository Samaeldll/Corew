/*
 * This file is part of the WarheadCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef _AUTH_BIGNUMBER_H
#define _AUTH_BIGNUMBER_H

#include "Define.h"
#include "Errors.h"
#include <array>
#include <memory>
#include <string>
#include <vector>

struct bignum_st;

class WH_COMMON_API BigNumber
{
public:
    BigNumber();
    BigNumber(BigNumber const& bn);
    BigNumber(uint32 v) : BigNumber() { SetDword(v); }
    BigNumber(int32 v) : BigNumber() { SetDword(v); }
    BigNumber(std::string const& v) : BigNumber() { SetHexStr(v); }
    template<size_t Size>
    BigNumber(std::array<uint8, Size> const& v, bool littleEndian = true) : BigNumber() { SetBinary(v.data(), Size, littleEndian); }

    ~BigNumber();

    void SetDword(int32);
    void SetDword(uint32);
    void SetQword(uint64);
    void SetBinary(uint8 const* bytes, int32 len, bool littleEndian = true);
    template<typename Container>
    auto SetBinary(Container const& c, bool littleEndian = true) -> std::enable_if_t<!std::is_pointer_v<std::decay_t<Container>>> { SetBinary(std::data(c), std::size(c), littleEndian); }
    void SetHexStr(char const* str);
    void SetHexStr(std::string const& str) { SetHexStr(str.c_str()); }

    void SetRand(int32 numbits);

    BigNumber& operator=(BigNumber const& bn);

    BigNumber operator+=(BigNumber const& bn);
    BigNumber operator+(BigNumber const& bn) const
    {
        BigNumber t(*this);
        return t += bn;
    }

    BigNumber operator-=(BigNumber const& bn);
    BigNumber operator-(BigNumber const& bn) const
    {
        BigNumber t(*this);
        return t -= bn;
    }

    BigNumber operator*=(BigNumber const& bn);
    BigNumber operator*(BigNumber const& bn) const
    {
        BigNumber t(*this);
        return t *= bn;
    }

    BigNumber operator/=(BigNumber const& bn);
    BigNumber operator/(BigNumber const& bn) const
    {
        BigNumber t(*this);
        return t /= bn;
    }

    BigNumber operator%=(BigNumber const& bn);
    BigNumber operator%(BigNumber const& bn) const
    {
        BigNumber t(*this);
        return t %= bn;
    }

    [[nodiscard]] bool isZero() const;

    BigNumber ModExp(BigNumber const& bn1, BigNumber const& bn2) const;
    BigNumber Exp(BigNumber const&) const;

    int32 GetNumBytes() const;

    struct bignum_st* BN() { return _bn; }
    struct bignum_st const* BN() const { return _bn; }

    uint32 AsDword();

    void GetBytes(uint8* buf, size_t bufsize, bool littleEndian = true) const;
    std::vector<uint8> ToByteVector(int32 minSize = 0, bool littleEndian = true) const;

    template<std::size_t Size>
    std::array<uint8, Size> ToByteArray(bool littleEndian = true) const
    {
        std::array<uint8, Size> buf;
        GetBytes(buf.data(), Size, littleEndian);
        return buf;
    }

    [[nodiscard]] char* AsHexStr() const;
    [[nodiscard]] char* AsDecStr() const;

private:
    struct bignum_st* _bn;
};
#endif
