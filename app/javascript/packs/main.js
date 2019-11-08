
const calcTotal = function() {
    let total = Number($("#transaction_price").val()) * Number($("#transaction_number").val())
    $('#transaction_total').text(`Total: $${total.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,')}`)
    return total
}


const button = () => {
    let total = Number($("#transaction_price").val()) * Number($("#transaction_number").val())
    let fund = parseFloat($('#transaction_fund').text().slice(7).replace(/[^0-9.-]+/g,""))
    let onHand = Number($('#transaction_share_on_hand').text().slice(15))
    let number = Number($("#transaction_number").val())

    if (total > fund && $('#transaction_trade_type').val() === "Buy") {
        $('.transaction_button').hide();
        $('#transaction_msg').text(`Insufficient Fund!`).css('color', 'red')
        $('form.new_transaction').attr('action', '')
    }
    else if (total <= fund && $('#transaction_trade_type').val() === "Buy") {
        $('.transaction_button').show()
        $('#transaction_msg').text(``).css('color', 'red')

        $('form.new_transaction').attr('action', '/transactions')
    }
    else if (number > onHand && $('#transaction_trade_type').val() === "Sell") {
        $('.transaction_button').hide()
        $('#transaction_msg').text(`You don't have enough share!`).css('color', 'red')
        $('form.new_transaction').attr('action', '')
    }
    else if (number <= onHand && $('#transaction_trade_type').val() === "Sell") {
        $('.transaction_button').show()
        $('#transaction_msg').text(``).css('color', 'red')

        $('form.new_transaction').attr('action', '/transactions')
    }
}


const changeAction = () => {
    $('.search-form').attr('action', `/watchlists/${$('#nav-search-input').val()}`)
}



const main = function() {
    $('#transaction_number, #transaction_trade_type').on("change", (e)=>{ e.preventDefault(); calcTotal(); button()})

    $('#nav-search-input').on('change', changeAction())

    $('#trade_link').click((e)=>{ e.preventDefault(); $('#trade_form').toggle()})

    $('#new-post-link').click((e)=>{
        e.preventDefault();
        $('#post-title-input, #post-content-textarea').val("")
        $('.hidden-post-form form').attr("action", "/posts")
        $('.hidden-post-form').show()})
    $('#post-back-link').click((e)=>{ e.preventDefault(); $('.hidden-post-form').hide()})
    $('#post-reset-link').click((e)=>{
        e.preventDefault();
        $('#post-title-input, #post-content-textarea').val("")
    })

    const editPostLink = (node)=> {
        const info = $(node).attr("value").split("|")
        $('#post-title-input').val(info[1])
        $('#post-content-textarea').val(info[2])
        $('#post-scope-select').val(info[3]).change()
        $('.hidden-post').attr("action", "/posts/"+info[0])
        }

    $('.post-edit-link').click((event)=> {
        event.preventDefault()
        editPostLink(event.target)

        $('#post-form-legend').text("Edit Post")
        $('#new-post').submit()
        $('.hidden-post-form').show()})

}


$(document).ready(main)
