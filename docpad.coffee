# http://docpad.org/docs/config

cheerio = require('cheerio')

# Define the DocPad Configuration
docpadConfig = {

  templateData:
  # Specify some site properties
    site:
    # The production url of our website
      url: "https://scottwalkersbaldspot.com"
    # The production url of our website

    # The default title of our website
      title: "The Adventures of Scott Walker's Bald Spot"

    # The website author's name
      author: "Scott Walker's Bald Spot"

    # The website author's email
      email: "scottwalkerbaldspot@gmail.com"

    # cache-busting timestamp
      timestamp: new Date().getTime()


 # -----------------------------
  # Helper Functions

  # Get the prepared site/document title
  # Often we would like to specify particular formatting to our page's title
  # we can apply that formatting here

    getPreparedTitle: ->
      # if we have a document title, then we should use that and suffix the site's title onto it
      if @document.title
        "#{@document.title} - #{@site.title}"
        # if our document does not have it's own title, then we should just use the site's title
      else
        @site.title

    fixLinks: (content, baseUrlOverride) ->
          baseUrl = @site.url
          if baseUrlOverride
            baseUrl = baseUrlOverride
          regex = /^(http|https|ftp|mailto):/

          $ = cheerio.load(content)
          $('img').each ->
            $img = $(@)
            src = $img.attr('src')
            $img.attr('src', baseUrl + src) unless regex.test(src)
          $('a').each ->
            $a = $(@)
            href = $a.attr('href')
            $a.attr('href', baseUrl + href) unless regex.test(href)
          $.html()



outPath: 'public'


}

# Export the DocPad Configuration
module.exports = docpadConfig
