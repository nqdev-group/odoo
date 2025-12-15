# Odoo Wiki - Hướng dẫn toàn diện

Chào mừng đến với Wiki hướng dẫn về Odoo - Nền tảng ERP mã nguồn mở hàng đầu!

## 📖 Giới thiệu về Odoo

Odoo (trước đây là OpenERP) là một bộ ứng dụng doanh nghiệp mã nguồn mở toàn diện, được thiết kế để đáp ứng mọi nhu cầu quản lý doanh nghiệp. Từ công ty nhỏ đến tập đoàn lớn, Odoo cung cấp giải pháp linh hoạt và dễ tùy chỉnh.

### Lịch sử phát triển

- **2005**: Ra mắt với tên TinyERP
- **2008**: Đổi tên thành OpenERP
- **2014**: Đổi tên thành Odoo và chuyển sang mô hình freemium
- **Hiện tại**: Phiên bản 17.0 (2023) với hàng nghìn module và cộng đồng toàn cầu

### Tại sao chọn Odoo?

1. **Toàn diện**: Tất cả tính năng trong một hệ thống
2. **Mã nguồn mở**: Minh bạch, có thể tùy chỉnh tự do
3. **Chi phí thấp**: Phiên bản Community hoàn toàn miễn phí
4. **Linh hoạt**: Dễ dàng mở rộng và tùy chỉnh
5. **Cộng đồng lớn**: Hỗ trợ tốt từ cộng đồng toàn cầu
6. **Cập nhật thường xuyên**: Phát hành phiên bản mới hàng năm

## 🎯 Các phiên bản Odoo

### Odoo Community Edition (CE)
- **Miễn phí**: 100% mã nguồn mở
- **Tính năng cốt lõi**: CRM, Bán hàng, Kho, Sản xuất, Kế toán
- **License**: LGPL v3
- **Phù hợp**: Doanh nghiệp vừa và nhỏ, developers

### Odoo Enterprise Edition (EE)
- **Trả phí**: Subscription model
- **Tính năng nâng cao**: Studio, IoT, Marketing Automation, Accounting Reports
- **Support**: Hỗ trợ chính thức từ Odoo S.A.
- **License**: Odoo Enterprise License
- **Phù hợp**: Doanh nghiệp lớn cần support chuyên nghiệp

### Odoo.sh
- **Platform-as-a-Service**: Cloud hosting do Odoo quản lý
- **Tự động**: Backup, scaling, updates
- **DevOps**: CI/CD tích hợp sẵn

## ��️ Kiến trúc Odoo

### Kiến trúc tổng quan

```
┌─────────────────────────────────────────────────┐
│              Web Browser / Mobile App           │
└────────────────┬────────────────────────────────┘
                 │ HTTP/HTTPS
                 │
┌────────────────▼────────────────────────────────┐
│            Web Server (Nginx/Apache)            │
│              Reverse Proxy & SSL                │
└────────────────┬────────────────────────────────┘
                 │
┌────────────────▼────────────────────────────────┐
│              Odoo Server (Python)               │
│  ┌──────────────────────────────────────────┐  │
│  │         Web Framework (Werkzeug)         │  │
│  └──────────────────┬───────────────────────┘  │
│                     │                           │
│  ┌─────────────────▼────────────────────────┐  │
│  │        Business Logic (Models)           │  │
│  │  ┌────────────┐      ┌────────────┐      │  │
│  │  │  Modules   │◄────►│ OWL/QWeb   │      │  │
│  │  │  (Python)  │      │ (Frontend) │      │  │
│  │  └──────┬─────┘      └────────────┘      │  │
│  │         │                                 │  │
│  │  ┌──────▼─────────────────────────────┐  │  │
│  │  │        Odoo ORM                    │  │  │
│  │  └──────┬─────────────────────────────┘  │  │
│  └─────────┼────────────────────────────────┘  │
└────────────┼────────────────────────────────────┘
             │
┌────────────▼────────────────────────────────────┐
│          PostgreSQL Database                    │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐      │
│  │  Tables  │  │  Views   │  │  Rules   │      │
│  └──────────┘  └──────────┘  └──────────┘      │
└─────────────────────────────────────────────────┘
```

### Thành phần chính

#### 1. Odoo Server (Backend)
- **Web Server**: Werkzeug WSGI server
- **ORM**: Object-Relational Mapping
- **Business Logic**: Python models
- **API**: XML-RPC, JSON-RPC
- **Reports**: QWeb templates, PDF generation

#### 2. Frontend
- **OWL Framework**: Odoo Web Library (JavaScript framework)
- **QWeb**: Template engine
- **Bootstrap**: CSS framework
- **jQuery**: JavaScript library (legacy)

#### 3. Database
- **PostgreSQL**: Primary database
- **JSONB**: Structured data storage
- **Full-text search**: PostgreSQL tsvector

## 📦 Cấu trúc Module Odoo

### Anatomy of an Odoo Module

```python
my_module/
├── __init__.py                 # Package initializer
├── __manifest__.py             # Module metadata
│
├── models/                     # Business logic
│   ├── __init__.py
│   ├── my_model.py            # Main model
│   └── inherited_model.py     # Model inheritance
│
├── views/                      # User interface
│   ├── my_model_views.xml     # Form, tree, kanban views
│   ├── templates.xml          # QWeb templates
│   └── menu.xml               # Menu definitions
│
├── security/                   # Access control
│   ├── ir.model.access.csv    # Model access rights
│   └── security.xml           # Record rules
│
├── data/                       # Master data
│   ├── data.xml               # Default data
│   └── demo.xml               # Demo data
│
├── controllers/                # Web controllers
│   ├── __init__.py
│   └── main.py                # HTTP routes
│
├── static/                     # Frontend assets
│   ├── description/
│   │   ├── icon.png           # Module icon
│   │   └── index.html         # Module description
│   └── src/
│       ├── js/                # JavaScript files
│       ├── css/               # Stylesheets
│       ├── xml/               # XML templates
│       └── img/               # Images
│
├── wizard/                     # Transient models
│   ├── __init__.py
│   └── my_wizard.py
│
├── report/                     # Report definitions
│   ├── __init__.py
│   ├── report.xml             # Report declarations
│   └── report_template.xml    # QWeb report templates
│
└── tests/                      # Unit tests
    ├── __init__.py
    └── test_my_module.py
```

### __manifest__.py chi tiết

```python
{
    # Module information
    'name': 'Module Name',
    'version': '17.0.1.0.0',      # Odoo version.module version
    'category': 'Sales',           # Module category
    'summary': 'Short description',
    'sequence': 10,                # Loading sequence
    
    # Description
    'description': """
        Long description of the module.
        Can be multiple lines.
    """,
    
    # Author
    'author': 'Your Company',
    'website': 'https://www.yourcompany.com',
    'maintainer': 'Maintainer Name',
    
    # License
    'license': 'LGPL-3',          # LGPL-3, OPL-1, etc.
    
    # Dependencies
    'depends': [
        'base',                    # Base module
        'sale',                    # Sales module
        'stock',                   # Inventory module
    ],
    
    # Data files
    'data': [
        # Security
        'security/security.xml',
        'security/ir.model.access.csv',
        
        # Master data
        'data/data.xml',
        
        # Views
        'views/menu.xml',
        'views/my_model_views.xml',
        'views/templates.xml',
        
        # Reports
        'report/report.xml',
        'report/report_template.xml',
        
        # Wizards
        'wizard/wizard_views.xml',
    ],
    
    # Demo data
    'demo': [
        'demo/demo.xml',
    ],
    
    # Assets (Web)
    'assets': {
        'web.assets_backend': [
            'my_module/static/src/js/**/*',
            'my_module/static/src/css/**/*',
        ],
    },
    
    # Configuration
    'installable': True,           # Can be installed
    'application': True,           # Is an application (appears in Apps)
    'auto_install': False,         # Auto-install if dependencies met
    
    # External dependencies
    'external_dependencies': {
        'python': ['pandas', 'numpy'],
        'bin': ['wkhtmltopdf'],
    },
    
    # Images
    'images': ['static/description/banner.png'],
    
    # Price (for Odoo Apps)
    'price': 99.00,
    'currency': 'EUR',
}
```

## 💻 Phát triển Module

### 1. Tạo Model

```python
from odoo import models, fields, api
from odoo.exceptions import UserError, ValidationError

class ProductTemplate(models.Model):
    _name = 'product.template'
    _description = 'Product Template'
    _inherit = ['mail.thread', 'mail.activity.mixin']
    _order = 'name'
    
    # Basic fields
    name = fields.Char('Product Name', required=True, translate=True)
    description = fields.Text('Description')
    active = fields.Boolean('Active', default=True)
    
    # Relational fields
    categ_id = fields.Many2one('product.category', 'Category', required=True)
    product_variant_ids = fields.One2many('product.product', 'product_tmpl_id', 'Variants')
    supplier_ids = fields.Many2many('res.partner', string='Suppliers')
    
    # Computed fields
    variant_count = fields.Integer('Variant Count', compute='_compute_variant_count')
    
    # Selection field
    type = fields.Selection([
        ('product', 'Storable Product'),
        ('consu', 'Consumable'),
        ('service', 'Service')
    ], string='Product Type', default='product', required=True)
    
    # Monetary field
    list_price = fields.Float('Sales Price', default=1.0)
    currency_id = fields.Many2one('res.currency', 'Currency')
    
    # Compute method
    @api.depends('product_variant_ids')
    def _compute_variant_count(self):
        for template in self:
            template.variant_count = len(template.product_variant_ids)
    
    # Constraint
    @api.constrains('list_price')
    def _check_price(self):
        for record in self:
            if record.list_price < 0:
                raise ValidationError("Price cannot be negative!")
    
    # CRUD override
    @api.model
    def create(self, vals):
        # Custom logic before create
        record = super(ProductTemplate, self).create(vals)
        # Custom logic after create
        return record
    
    def write(self, vals):
        # Custom logic before write
        result = super(ProductTemplate, self).write(vals)
        # Custom logic after write
        return result
    
    def unlink(self):
        # Custom logic before delete
        if any(product.state == 'done' for product in self):
            raise UserError("Cannot delete a product in done state!")
        return super(ProductTemplate, self).unlink()
    
    # Action method
    def action_archive(self):
        self.write({'active': False})
```

### 2. Kế thừa Model

#### Kế thừa cổ điển (_inherit với cùng _name)

```python
class ResPartner(models.Model):
    _inherit = 'res.partner'
    
    # Add new fields
    customer_rank = fields.Integer('Customer Rank')
    
    # Override method
    def write(self, vals):
        # Custom logic
        return super(ResPartner, self).write(vals)
```

#### Kế thừa bằng delegation (_inherits)

```python
class ProductProduct(models.Model):
    _name = 'product.product'
    _inherits = {'product.template': 'product_tmpl_id'}
    
    product_tmpl_id = fields.Many2one('product.template', 'Product Template', required=True, ondelete='cascade')
    default_code = fields.Char('Internal Reference')
```

### 3. Định nghĩa Views

#### Form View

```xml
<record id="view_product_form" model="ir.ui.view">
    <field name="name">product.template.form</field>
    <field name="model">product.template</field>
    <field name="arch" type="xml">
        <form string="Product">
            <!-- Header with status bar -->
            <header>
                <button name="action_archive" string="Archive" type="object" class="btn-primary"/>
                <field name="state" widget="statusbar"/>
            </header>
            
            <sheet>
                <!-- Title -->
                <div class="oe_title">
                    <label for="name" string="Product Name"/>
                    <h1><field name="name" placeholder="Product Name"/></h1>
                </div>
                
                <!-- Notebook (tabs) -->
                <notebook>
                    <page string="General Information">
                        <group>
                            <group>
                                <field name="type"/>
                                <field name="categ_id"/>
                            </group>
                            <group>
                                <field name="list_price"/>
                                <field name="currency_id" invisible="1"/>
                            </group>
                        </group>
                    </page>
                    
                    <page string="Variants">
                        <field name="product_variant_ids">
                            <tree>
                                <field name="name"/>
                                <field name="default_code"/>
                            </tree>
                        </field>
                    </page>
                    
                    <page string="Suppliers">
                        <field name="supplier_ids"/>
                    </page>
                </notebook>
            </sheet>
            
            <!-- Chatter -->
            <div class="oe_chatter">
                <field name="message_follower_ids"/>
                <field name="activity_ids"/>
                <field name="message_ids"/>
            </div>
        </form>
    </field>
</record>
```

#### Tree View

```xml
<record id="view_product_tree" model="ir.ui.view">
    <field name="name">product.template.tree</field>
    <field name="model">product.template</field>
    <field name="arch" type="xml">
        <tree string="Products" decoration-muted="not active">
            <field name="name"/>
            <field name="categ_id"/>
            <field name="type"/>
            <field name="list_price"/>
            <field name="variant_count"/>
            <field name="active" invisible="1"/>
        </tree>
    </field>
</record>
```

#### Kanban View

```xml
<record id="view_product_kanban" model="ir.ui.view">
    <field name="name">product.template.kanban</field>
    <field name="model">product.template</field>
    <field name="arch" type="xml">
        <kanban>
            <field name="id"/>
            <field name="name"/>
            <field name="list_price"/>
            <templates>
                <t t-name="kanban-box">
                    <div class="oe_kanban_global_click">
                        <div class="o_kanban_image">
                            <img t-att-src="kanban_image('product.template', 'image_128', record.id.raw_value)"/>
                        </div>
                        <div class="oe_kanban_details">
                            <strong class="o_kanban_record_title">
                                <field name="name"/>
                            </strong>
                            <div>
                                Price: <field name="list_price"/>
                            </div>
                        </div>
                    </div>
                </t>
            </templates>
        </kanban>
    </field>
</record>
```

#### Search View

```xml
<record id="view_product_search" model="ir.ui.view">
    <field name="name">product.template.search</field>
    <field name="model">product.template</field>
    <field name="arch" type="xml">
        <search string="Products">
            <!-- Search fields -->
            <field name="name" string="Product" filter_domain="['|', ('name', 'ilike', self), ('default_code', 'ilike', self)]"/>
            <field name="categ_id"/>
            
            <!-- Filters -->
            <filter string="Services" name="services" domain="[('type', '=', 'service')]"/>
            <filter string="Products" name="consumable" domain="[('type', 'in', ['product', 'consu'])]"/>
            <separator/>
            <filter string="Archived" name="inactive" domain="[('active', '=', False)]"/>
            
            <!-- Group by -->
            <group expand="0" string="Group By">
                <filter string="Category" name="categ_id" context="{'group_by': 'categ_id'}"/>
                <filter string="Type" name="type" context="{'group_by': 'type'}"/>
            </group>
        </search>
    </field>
</record>
```

### 4. Actions và Menus

```xml
<!-- Action -->
<record id="action_product_template" model="ir.actions.act_window">
    <field name="name">Products</field>
    <field name="res_model">product.template</field>
    <field name="view_mode">kanban,tree,form</field>
    <field name="context">{'search_default_consumable': 1}</field>
    <field name="help" type="html">
        <p class="o_view_nocontent_smiling_face">
            Create a new product
        </p>
    </field>
</record>

<!-- Menu -->
<menuitem id="menu_product_root"
          name="Products"
          sequence="10"/>

<menuitem id="menu_product_template"
          name="Products"
          parent="menu_product_root"
          action="action_product_template"
          sequence="1"/>
```

## 🔐 Security

### Access Rights (ir.model.access.csv)

```csv
id,name,model_id:id,group_id:id,perm_read,perm_write,perm_create,perm_unlink
access_product_template_user,product.template.user,model_product_template,base.group_user,1,0,0,0
access_product_template_manager,product.template.manager,model_product_template,base.group_system,1,1,1,1
```

### Record Rules

```xml
<record id="product_template_comp_rule" model="ir.rule">
    <field name="name">Product Template: multi-company</field>
    <field name="model_id" ref="model_product_template"/>
    <field name="domain_force">[('company_id', 'in', company_ids)]</field>
</record>
```

## 🎨 OWL Components

### JavaScript Component

```javascript
/** @odoo-module **/

import { Component } from "@odoo/owl";
import { registry } from "@web/core/registry";

class MyComponent extends Component {
    setup() {
        this.state = {
            counter: 0,
        };
    }
    
    increment() {
        this.state.counter++;
    }
}

MyComponent.template = "my_module.MyComponent";

registry.category("actions").add("my_component", MyComponent);
```

### XML Template

```xml
<?xml version="1.0" encoding="UTF-8"?>
<templates xml:space="preserve">
    <t t-name="my_module.MyComponent" owl="1">
        <div class="my-component">
            <h3>Counter: <t t-esc="state.counter"/></h3>
            <button class="btn btn-primary" t-on-click="increment">
                Increment
            </button>
        </div>
    </t>
</templates>
```

## 📊 Reports (QWeb)

### Report Declaration

```xml
<record id="action_report_invoice" model="ir.actions.report">
    <field name="name">Invoice</field>
    <field name="model">account.move</field>
    <field name="report_type">qweb-pdf</field>
    <field name="report_name">account.report_invoice</field>
    <field name="report_file">account.report_invoice</field>
    <field name="binding_model_id" ref="model_account_move"/>
    <field name="binding_type">report</field>
</record>
```

### Report Template

```xml
<template id="report_invoice">
    <t t-call="web.html_container">
        <t t-foreach="docs" t-as="o">
            <t t-call="web.external_layout">
                <div class="page">
                    <h2>Invoice #<span t-field="o.name"/></h2>
                    
                    <div class="row">
                        <div class="col-6">
                            <strong>Customer:</strong><br/>
                            <span t-field="o.partner_id.name"/><br/>
                            <span t-field="o.partner_id.street"/>
                        </div>
                        <div class="col-6">
                            <strong>Invoice Date:</strong>
                            <span t-field="o.invoice_date"/><br/>
                            <strong>Due Date:</strong>
                            <span t-field="o.invoice_date_due"/>
                        </div>
                    </div>
                    
                    <table class="table table-sm">
                        <thead>
                            <tr>
                                <th>Product</th>
                                <th class="text-right">Quantity</th>
                                <th class="text-right">Price</th>
                                <th class="text-right">Amount</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr t-foreach="o.invoice_line_ids" t-as="line">
                                <td><span t-field="line.product_id.name"/></td>
                                <td class="text-right"><span t-field="line.quantity"/></td>
                                <td class="text-right"><span t-field="line.price_unit"/></td>
                                <td class="text-right"><span t-field="line.price_subtotal"/></td>
                            </tr>
                        </tbody>
                    </table>
                    
                    <div class="row">
                        <div class="col-6"/>
                        <div class="col-6">
                            <table class="table table-sm">
                                <tr>
                                    <td><strong>Total:</strong></td>
                                    <td class="text-right">
                                        <span t-field="o.amount_total"/>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
            </t>
        </t>
    </t>
</template>
```

## 🧪 Testing

### Unit Test

```python
from odoo.tests.common import TransactionCase
from odoo.exceptions import ValidationError

class TestProduct(TransactionCase):
    
    def setUp(self):
        super(TestProduct, self).setUp()
        self.Product = self.env['product.template']
        self.category = self.env['product.category'].create({
            'name': 'Test Category'
        })
    
    def test_create_product(self):
        """Test product creation"""
        product = self.Product.create({
            'name': 'Test Product',
            'categ_id': self.category.id,
            'list_price': 100.0,
        })
        self.assertEqual(product.name, 'Test Product')
        self.assertEqual(product.list_price, 100.0)
    
    def test_price_constraint(self):
        """Test price cannot be negative"""
        with self.assertRaises(ValidationError):
            self.Product.create({
                'name': 'Invalid Product',
                'categ_id': self.category.id,
                'list_price': -10.0,
            })
```

### Run Tests

```bash
# Run all tests for a module
./odoo-bin -d test_db -i my_module --test-enable --stop-after-init

# Run specific test
./odoo-bin -d test_db --test-tags my_module.tests.test_product
```

## 🚀 Best Practices

### 1. Code Quality

```python
# Good: Clear, descriptive names
def _compute_total_amount(self):
    for record in self:
        record.total_amount = sum(record.line_ids.mapped('amount'))

# Bad: Unclear, abbreviated names
def _comp_tot(self):
    for r in self:
        r.tot = sum(r.l.mapped('a'))
```

### 2. Performance

```python
# Good: Use search_read
products = self.env['product.product'].search_read(
    [('active', '=', True)],
    ['name', 'list_price']
)

# Bad: Separate search and read
products = self.env['product.product'].search([('active', '=', True)])
for product in products:
    name = product.name  # Triggers read for each record
```

### 3. Security

```python
# Good: Use sudo carefully
def action_validate(self):
    self.ensure_one()
    if self.env.user.has_group('base.group_system'):
        self.sudo().write({'state': 'done'})

# Bad: Unrestricted sudo
def action_validate(self):
    self.sudo().write({'state': 'done'})  # Anyone can validate!
```

## 📚 Resources

### Official Documentation
- [Odoo Documentation](https://www.odoo.com/documentation/17.0/)
- [Developer Tutorials](https://www.odoo.com/documentation/17.0/developer/tutorials.html)
- [API Reference](https://www.odoo.com/documentation/17.0/developer/reference.html)

### Community Resources
- [Odoo Community Association (OCA)](https://odoo-community.org/)
- [Odoo GitHub](https://github.com/odoo/odoo)
- [OCA GitHub](https://github.com/OCA)

### Learning
- [Odoo eLearning](https://www.odoo.com/slides)
- [Odoo Forum](https://www.odoo.com/forum)
- [Odoo Apps Store](https://apps.odoo.com/)

## 🤝 Contributing

Đóng góp vào tài liệu này bằng cách:

1. Fork repository
2. Tạo branch mới
3. Thêm/cập nhật tài liệu
4. Tạo Pull Request

---

Quay lại [docs/README.md](../README.md) | [README.md chính](../../README.md)
