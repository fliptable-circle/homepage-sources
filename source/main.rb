require 'redcarpet'

def create_page(url, title, options={}, &block)

	topnav_page url, "(╯°□°）╯︵ ┻━┻ | #{title}" do

		menu do
			nav "Home", :home, "/"
			nav "About", :newspaper_o, "/about/"
			nav "Books", :book, "/books/"
			nav "Astrobunny", :child, "/astrobunny/"
			nav "TronBonne", :child, "/tronbonne/"
			nav "Kaiyochin", :child, "/kaiyochin/"
		end

		row do
			col 2, xs: 0, sm: 0, md: 1 do
			end

			col 8, xs: 12, sm: 12, md: 10 do

				if options[:title_image]
					image options[:title_image], rounded_corners: true
				else
					image "chino-title.png", rounded_corners: :top
				end

				hr

				div &block
			end

			col 2, xs: 0, sm: 0, md: 1 do
			end
		end

	end

end

def post_name_to_url_path(md_file)
	md_file.gsub(/-/, "/").gsub(/blog\//,"").gsub(".md", "")
end


def render(md_file)
	meta = YAML.load_file(md_file)
	renderer = Redcarpet::Render::HTML.new()
	markdown = Redcarpet::Markdown.new(renderer, autolink: true, tables: true)
	content = File.read(md_file).split("---", 2)[1]

	if meta["toppic"]
		div align:"center" do
			image meta["toppic"]
		end
		hr
	end

	rendered = markdown.render(content)

	rendered.gsub!(/<img src="(.+?)"/, '<img class="img-responsive" src="/images/\\1"')

	text rendered

	if meta["gallery"]

		gallery(
			meta["gallery"].map{|x| "/images/" + x}, 
			meta["gallery"].map{|x| "/images/" + x.sub(".", "-thumb.")})
		
	end

end