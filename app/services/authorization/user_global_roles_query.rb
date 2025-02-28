#-- copyright
# OpenProject is an open source project management software.
# Copyright (C) the OpenProject GmbH
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License version 3.
#
# OpenProject is a fork of ChiliProject, which is a fork of Redmine. The copyright follows:
# Copyright (C) 2006-2013 Jean-Philippe Lang
# Copyright (C) 2010-2013 the ChiliProject Team
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#
# See COPYRIGHT and LICENSE files for more details.
#++

class Authorization::UserGlobalRolesQuery < Authorization::UserRolesQuery
  transformations.register roles_member_roles_join,
                           :builtin_role do |statement, user|
    builtin_role = if user.logged?
                     Role::BUILTIN_NON_MEMBER
                   else
                     Role::BUILTIN_ANONYMOUS
                   end

    builtin_role_condition = roles_table[:builtin].eq(builtin_role)

    statement.or(builtin_role_condition)
  end

  transformations.register :all, :global_group_where_projection do |statement, user|
    statement.group(roles_table[:id])
             .where(users_table[:id].eq(user.id))
  end

  transformations.register users_members_join, :entity_restriction do |statement, _|
    statement
      .and(members_table[:entity_type].eq(nil))
      .and(members_table[:entity_id].eq(nil))
  end
end
