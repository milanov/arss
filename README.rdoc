#arss

_arss_ is a very simple and highly opinionated RSS (for now) parser. It can parse both urls, local files and text
directly. The current functionality is limited to parsing only RSS feeds, but in the future any strictly formatted
xml text should be parsed.
**NOTE:** This is a univercity related project, so don't rely on it in a production environment.

##Example:
  feed = <<-FEED
  <rss>
    <!-- look at me now -->
    <channel>
      <title>Pedro Almodovar</title>
      <description><![CDATA[A list of some of <description>Almodovar's</description> best movies.]]></description>
      <image>
        <width>2</width>
        <height>2</height>
      </image>
      <item>
        <title>La piel que habito</title>
        <description>A brilliant plastic surgeon, haunted by past tragedies..</description>
      </item>
      <item>
        <title>Hable con ella</title>
        <description>Two men share an odd friendship while they care for..</description>
      </item>
    </channel>
  </rss>
  FEED

  require 'arss'
  Arss::FeedParser.parse(feed)

  # {"channel"=>
  # {"title"=>"Pedro Almodovar",
  # "description"=>"A list of some of Almodovar's best movies."
  # "image"=>{"width"=>"2", "height"=>"2"},
  # "items"=>
  #  [{"title"=>"La piel que habito",
  #    "description"=>
  #     "A brilliant plastic surgeon, haunted by past tragedies.."},
  #   {"title"=>"Hable con ella",
  #    "description"=>
  #     "Two men share an odd friendship while they care for.."}]}}

##Contributing to arss:

* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

##Copyright

Copyright (c) 2013 Milan Milanov. See LICENSE.txt for further details.
