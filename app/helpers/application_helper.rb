module ApplicationHelper
    def safe_external_url(url)
        uri = URI.parse(url.to_s) rescue nil
        return nil unless uri.is_a?(URI::HTTP) && uri.host.present?
        uri.to_s
    end

    def tidal_playlist_embed_src(url)
        return nil if url.blank?

        match = url.to_s.match(%r{playlist/([a-zA-Z0-9\-]+)})
        return nil unless match

        "https://embed.tidal.com/playlists/#{match[1]}"
    end
end
