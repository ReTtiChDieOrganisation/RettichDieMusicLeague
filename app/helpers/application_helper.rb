module ApplicationHelper
    def safe_external_url(url)
        uri = URI.parse(url.to_s) rescue nil
        return nil unless uri.is_a?(URI::HTTP) && uri.host.present?
        uri.to_s
    end

    def mobile_nav_classes(path)
        base_classes = "flex flex-col items-center justify-center flex-1 text-gray-400 hover:text-soundcloud-orange transition-all duration-200"
        active_classes = "text-soundcloud-orange glow-orange"
        current_page?(path) ? "#{base_classes} #{active_classes}" : base_classes
    end

    def winner_text_class(index)
        index == 0 ? 'gradient-orange bg-clip-text text-transparent' : 'text-soundcloud-orange'
    end
end
