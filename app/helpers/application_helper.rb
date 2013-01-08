module ApplicationHelper
  def dibs_referral_body
    product_info = ["======", ""]
    @order.line_items.each do |item|
      product_info << "#{item.variant.sku}  #{raw(item.variant.product.name)}  #{raw(item.variant.options_text)}"
      unless item.ad_hoc_option_values.empty?
        item.ad_hoc_option_values.each do |pov|
          product_info << "#{pov.option_value.option_type.presentation} = #{pov.option_value.presentation} #{"," unless pov == item.ad_hoc_option_values.last}"
        end
      end
      product_info << "(#{item.quantity}) @ #{number_to_currency item.price} = #{number_to_currency(item.price * item.quantity)}"
      product_info << ""
    end
    product_info << "======"
    product_info << "Subtotal: #{number_to_currency @order.item_total}"
    @order.adjustments.each do |adjustment|
      product_info << "#{raw(adjustment.label)} #{number_to_currency(adjustment.amount)}"
    end
    product_info << "Order Total: #{number_to_currency(@order.total)}"
    "http://#{Spree::Config[:site_url]}/dibs_referral?dibs_referral=#{URI::encode_www_form_component @current_user.email}&#{@order.dibs_referral_line_items.to_param}\n\n#{product_info.join("\n")}"
  end
end
