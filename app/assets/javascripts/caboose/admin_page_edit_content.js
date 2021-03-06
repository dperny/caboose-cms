
var PageContentController = function(page_id) { this.init(page_id); };

PageContentController.prototype = {

  page_id: false,    
  new_block_type_id: false,
  
  init: function(page_id)
  {
    this.page_id = page_id;
    var that = this;
    that.set_clickable();   
    //this.render_blocks(function() {
    //  that.sortable_blocks();
    //  that.draggable_blocks();
    //});
  },
  
  sortable_blocks: function()
  { 
    var that = this;
    $('#blocks').sortable({
      //hoverClass: "ui-state-active",
      placeholder: 'sortable-placeholder',
      forcePlaceholderSize: true,
      handle: '.sort_handle',
      receive: function(e, ui) {      
        that.new_block_type_id = ui.item.attr('id').replace('new_block_', '');    
      },
      update: function(e, ui) {        
        if (that.new_block_type_id)
        {
          $.ajax({
            url: '/admin/pages/' + that.page_id + '/blocks',
            type: 'post',
            data: { block_type_id: that.new_block_type_id, index: ui.item.index() },
            success: function(resp) { that.render_blocks(function() { that.edit_block(resp.block.id); }); }
          });                    
          that.new_block_type_id = false;
        }
        else
        {        
          $.ajax({
            url: '/admin/pages/' + that.page_id + '/block-order',
            type: 'put',
            data: $('#blocks').sortable('serialize', { key: "block_ids[]" }),
            success: function(resp) {}
          });
        }
      }
    });
  },
  
  draggable_blocks: function() 
  {
    $('#new_blocks li').draggable({
      dropOnEmpty: true,
      connectToSortable: "#blocks",
      helper: "clone",
      revert: "invalid"    
    });    
  },
    
  edit_block: function(block_id)
  {
    caboose_modal_url('/admin/pages/' + this.page_id + '/blocks/' + block_id + '/edit');    
  },
  
  new_block: function(block_id)
  {
    caboose_modal_url('/admin/pages/' + this.page_id + '/blocks/' + block_id + '/new');    
  },
  
  delete_block: function(block_id, confirm)
  {
    var that = this;        
    if (!confirm)
    {
      var p = $('<p/>')
        .addClass('note warning')
        .append("Are you sure you want to delete the block? ")
        .append($('<input/>').attr('type', 'button').val('Yes').click(function() { that.delete_block(block_id, true); })).append(" ")
        .append($('<input/>').attr('type', 'button').val('No').click(function() { that.render_block(block_id); }));
      $('#block_container_' + block_id).attr('onclick','').unbind('click');
      $('#block_container_' + block_id).empty().append(p);
      return;
    }
    $.ajax({
      url: '/admin/pages/' + this.page_id + '/blocks/' + block_id,
      type: 'delete',
      success: function(resp) {
        that.render_blocks();      
      }
    });    
  },
    
  /*****************************************************************************
  Block Rendering
  *****************************************************************************/
  
  render_blocks: function() {
    var that = this;                
    $.ajax({
      url: '/admin/pages/' + this.page_id + '/blocks/render-second-level',
      success: function(blocks) {
        $(blocks).each(function(i, b) {
          $('#block_' + b.id).replaceWith(b.html);
        });
        that.set_clickable();
      }
    });
  },
         
  set_clickable: function()
  {        
    var that = this;                
    $.ajax({      
      url: '/admin/pages/' + this.page_id + '/blocks/tree',
      success: function(blocks) {        
        $(blocks).each(function(i,b) {
          that.set_clickable_helper(b);                      
        });
      }
    });    
  },
  
  set_clickable_helper: function(b)
  {    
    var that = this;        
    $('#block_' + b.id).attr('onclick','').unbind('click');    
    $('#block_' + b.id).click(function(e) {
      e.stopPropagation();
      that.edit_block(b.id); 
    });
    if (b.allow_child_blocks == true)
    {
      $('#new_block_' + b.id).replaceWith($('<input/>')
        .attr('type', 'button')
        .val('New Block')
        .click(function(e) { e.stopPropagation(); that.new_block(b.id);          
        })
      );
    } 
    var show_mouseover = true;
    if (b.children && b.children.length > 0)
    {
      $.each(b.children, function(i, b2) {
        if (b2.block_type_id = 34)
          show_mouseover = false;
        that.set_clickable_helper(b2);
      });
    }    
    if (show_mouseover)
    {
      $('#block_' + b.id).mouseover(function(el) { $('#block_' + b.id).addClass(   'block_over'); });
      $('#block_' + b.id).mouseout(function(el)  { $('#block_' + b.id).removeClass('block_over'); }); 
    }    
  }    
  
};

function toggle_blocks()
{
  $('#new_blocks_container2').slideToggle();
}


