#-- copyright
# OpenProject is an open source project management software.
# Copyright (C) 2012-2023 the OpenProject GmbH
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

class OpenProject::JournalFormatter::TimeEntryHours < JournalFormatter::Base
  def render(_key, values, options = { html: true })
    label_text = 'Spent time'
    label_text << ':' if !values.first
    label_text = content_tag(:strong, label_text) if options[:html]

    # TODO - Italicize

    first = format_float(values.first) if values.first
    last = format_float(values.last)

    value = \
      if first
        I18n.t(:'activity.item.time_entry.updated',
               first: I18n.t(:'activity.item.time_entry.hour', count: first),
               last: I18n.t(:'activity.item.time_entry.hour', count: last))
      else
        I18n.t(:'activity.item.time_entry.hour',
               count: last)
      end
    # value = content_tag(:i, value) if options[:html]

    I18n.t(:text_journal_of, label: label_text, value:)
  end

  private

  def format_float(val)
    (val % 1).zero? ? val.to_i : val
  end
end
