# Odoo - Nền tảng ERP Mã nguồn Mở

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Odoo](https://img.shields.io/badge/Odoo-Platform-714B67.svg)](https://www.odoo.com/)

Tài liệu và tài nguyên học tập về Odoo - nền tảng quản lý doanh nghiệp nguồn mở hàng đầu thế giới.

## 📖 Odoo là gì?

Odoo là một bộ ứng dụng doanh nghiệp mã nguồn mở (Open Source ERP) toàn diện, bao gồm các module như CRM, thương mại điện tử, kế toán, kho vận, điểm bán hàng (POS), quản lý dự án, và nhiều hơn nữa. Tất cả được tích hợp hoàn hảo trong một hệ thống duy nhất.

### Đặc điểm nổi bật

- **Mã nguồn mở**: Cộng đồng phát triển lớn mạnh với hàng nghìn module
- **Tích hợp toàn diện**: Tất cả ứng dụng được tích hợp liền mạch
- **Linh hoạt**: Dễ dàng tùy chỉnh theo nhu cầu doanh nghiệp
- **Giao diện thân thiện**: UI/UX hiện đại, dễ sử dụng
- **Đa nền tảng**: Web, Mobile, Desktop

## 🎯 Các Module Chính

### 🛒 Bán hàng & CRM
- **CRM**: Quản lý khách hàng tiềm năng và cơ hội bán hàng
- **Bán hàng**: Quản lý báo giá, đơn hàng, hợp đồng
- **POS (Point of Sale)**: Hệ thống điểm bán hàng

### 💼 Vận hành
- **Kho vận**: Quản lý tồn kho, nhập xuất, chuyển kho
- **Sản xuất**: Quản lý quy trình sản xuất, BOM, lệnh sản xuất
- **Mua hàng**: Quản lý nhà cung cấp, yêu cầu báo giá, đơn mua hàng

### 💰 Tài chính & Kế toán
- **Kế toán**: Sổ cái, báo cáo tài chính, thuế
- **Hóa đơn**: Quản lý hóa đơn bán hàng và mua hàng
- **Chi phí**: Theo dõi chi phí và quản lý ngân sách

### 👥 Nhân sự
- **Nhân sự**: Quản lý nhân viên, hợp đồng, đánh giá
- **Tuyển dụng**: Quản lý tuyển dụng và ứng viên
- **Chấm công**: Theo dõi giờ làm việc, nghỉ phép
- **Lương**: Tính lương và các khoản phụ cấp

### 🌐 Website & Marketing
- **Website Builder**: Xây dựng website không cần code
- **Thương mại điện tử**: Cửa hàng trực tuyến tích hợp
- **Email Marketing**: Chiến dịch email marketing
- **Marketing tự động**: Automation marketing

### 📊 Quản lý dự án
- **Dự án**: Quản lý dự án, công việc, mốc thời gian
- **Timesheet**: Ghi nhận giờ làm việc
- **Helpdesk**: Hệ thống hỗ trợ khách hàng

## 🏗️ Kiến trúc Odoo

### Tech Stack

- **Backend**: Python (Framework Odoo)
- **Frontend**: JavaScript (OWL Framework), XML, QWeb
- **Database**: PostgreSQL
- **Web Server**: Werkzeug (WSGI)
- **ORM**: Odoo ORM (tích hợp sẵn)

### Cấu trúc Module Odoo

```
odoo_module/
├── __init__.py              # Python package init
├── __manifest__.py          # Module manifest (metadata)
├── models/                  # Business logic (Python)
│   ├── __init__.py
│   └── model_name.py
├── views/                   # UI definitions (XML)
│   ├── view_name.xml
│   └── menu.xml
├── security/                # Access rights
│   ├── ir.model.access.csv
│   └── security.xml
├── data/                    # Demo & master data
│   └── data.xml
├── controllers/             # Web controllers
│   ├── __init__.py
│   └── main.py
├── static/                  # Static assets
│   ├── src/
│   │   ├── js/
│   │   ├── css/
│   │   └── xml/
│   └── description/
│       └── icon.png
└── wizard/                  # Transient models
    ├── __init__.py
    └── wizard_name.py
```

## 🚀 Bắt đầu với Odoo

### Yêu cầu hệ thống

- **Python**: 3.8 trở lên
- **PostgreSQL**: 12 trở lên
- **Node.js**: (cho việc build assets)
- **wkhtmltopdf**: Để tạo PDF reports

### Cài đặt Odoo

#### Trên Ubuntu/Debian

```bash
# Cài đặt dependencies
sudo apt update
sudo apt install python3-pip python3-dev libxml2-dev libxslt1-dev \
    libldap2-dev libsasl2-dev libtiff5-dev libjpeg8-dev libopenjp2-7-dev \
    zlib1g-dev libfreetype6-dev liblcms2-dev libwebp-dev libharfbuzz-dev \
    libfribidi-dev libxcb1-dev libpq-dev git

# Cài đặt PostgreSQL
sudo apt install postgresql postgresql-client

# Clone Odoo repository
git clone https://github.com/odoo/odoo.git --depth 1 --branch 17.0
cd odoo

# Cài đặt Python dependencies
pip3 install -r requirements.txt

# Tạo database user cho Odoo
sudo -u postgres createuser -s $USER

# Chạy Odoo
./odoo-bin --addons-path=addons --db-filter=^mydb$ -d mydb -i base
```

#### Sử dụng Docker

```bash
# Pull Odoo image
docker pull odoo:17.0

# Chạy PostgreSQL
docker run -d -e POSTGRES_USER=odoo -e POSTGRES_PASSWORD=odoo \
    -e POSTGRES_DB=postgres --name db postgres:15

# Chạy Odoo
docker run -p 8069:8069 --name odoo --link db:db -t odoo:17.0
```

### Truy cập Odoo

Sau khi cài đặt, truy cập Odoo tại: `http://localhost:8069`

## 📚 Phát triển Module Odoo

### Tạo Module Mới

```bash
# Sử dụng scaffold để tạo module
./odoo-bin scaffold my_module addons/
```

### Cấu trúc __manifest__.py

```python
{
    'name': 'Tên Module',
    'version': '17.0.1.0.0',
    'category': 'Category',
    'summary': 'Mô tả ngắn',
    'description': """
        Mô tả chi tiết về module
    """,
    'author': 'Tên tác giả',
    'website': 'https://www.example.com',
    'license': 'LGPL-3',
    'depends': ['base', 'sale'],  # Dependencies
    'data': [
        'security/ir.model.access.csv',
        'views/view_name.xml',
        'data/data.xml',
    ],
    'demo': [
        'demo/demo.xml',
    ],
    'installable': True,
    'application': False,
    'auto_install': False,
}
```

### Định nghĩa Model

```python
from odoo import models, fields, api

class MyModel(models.Model):
    _name = 'my.model'
    _description = 'My Model Description'
    
    name = fields.Char(string='Name', required=True)
    description = fields.Text(string='Description')
    date = fields.Date(string='Date')
    active = fields.Boolean(string='Active', default=True)
    
    @api.depends('name')
    def _compute_display_name(self):
        for record in self:
            record.display_name = f"[{record.id}] {record.name}"
```

### Định nghĩa View (XML)

```xml
<?xml version="1.0" encoding="utf-8"?>
<odoo>
    <!-- Form View -->
    <record id="view_my_model_form" model="ir.ui.view">
        <field name="name">my.model.form</field>
        <field name="model">my.model</field>
        <field name="arch" type="xml">
            <form string="My Model">
                <sheet>
                    <group>
                        <field name="name"/>
                        <field name="description"/>
                        <field name="date"/>
                    </group>
                </sheet>
            </form>
        </field>
    </record>
    
    <!-- Tree View -->
    <record id="view_my_model_tree" model="ir.ui.view">
        <field name="name">my.model.tree</field>
        <field name="model">my.model</field>
        <field name="arch" type="xml">
            <tree string="My Models">
                <field name="name"/>
                <field name="date"/>
            </tree>
        </field>
    </record>
    
    <!-- Action -->
    <record id="action_my_model" model="ir.actions.act_window">
        <field name="name">My Models</field>
        <field name="res_model">my.model</field>
        <field name="view_mode">tree,form</field>
    </record>
    
    <!-- Menu -->
    <menuitem id="menu_my_model"
              name="My Models"
              action="action_my_model"
              sequence="10"/>
</odoo>
```

## 🔧 Tùy chỉnh & Mở rộng

### Kế thừa Model

```python
class PartnerExtended(models.Model):
    _inherit = 'res.partner'
    
    custom_field = fields.Char(string='Custom Field')
```

### Kế thừa View

```xml
<record id="view_partner_form_custom" model="ir.ui.view">
    <field name="name">res.partner.form.custom</field>
    <field name="model">res.partner</field>
    <field name="inherit_id" ref="base.view_partner_form"/>
    <field name="arch" type="xml">
        <xpath expr="//field[@name='email']" position="after">
            <field name="custom_field"/>
        </xpath>
    </field>
</record>
```

## 📖 Tài liệu tham khảo

### Tài liệu chính thức

- **Website**: [https://www.odoo.com/vi_VN](https://www.odoo.com/vi_VN)
- **Documentation**: [https://www.odoo.com/documentation/17.0/](https://www.odoo.com/documentation/17.0/)
- **Developer Docs**: [https://www.odoo.com/documentation/17.0/developer.html](https://www.odoo.com/documentation/17.0/developer.html)

### Cộng đồng

- **Odoo Community**: [https://www.odoo.com/forum](https://www.odoo.com/forum)
- **GitHub**: [https://github.com/odoo/odoo](https://github.com/odoo/odoo)
- **Odoo Apps Store**: [https://apps.odoo.com/](https://apps.odoo.com/)

### Học tập

- **Odoo eLearning**: [https://www.odoo.com/slides](https://www.odoo.com/slides)
- **Odoo Tutorials**: [https://www.odoo.com/page/docs](https://www.odoo.com/page/docs)

## 🛠️ Best Practices

### 1. Đặt tên Module
- Sử dụng prefix duy nhất (vd: `company_module_name`)
- Tên ngắn gọn, mô tả rõ ràng

### 2. Coding Standards
- Tuân thủ PEP 8 cho Python
- Sử dụng Odoo linting tools
- Comment code rõ ràng

### 3. Security
- Luôn định nghĩa access rights trong `ir.model.access.csv`
- Sử dụng record rules khi cần thiết
- Validate user input

### 4. Performance
- Sử dụng `@api.depends` cho computed fields
- Tránh vòng lặp trong vòng lặp
- Sử dụng `search_read()` thay vì `search()` + `read()`
- Tối ưu database queries

### 5. Testing
- Viết unit tests cho business logic
- Test với nhiều ngôn ngữ và timezone
- Test với nhiều dữ liệu mẫu

## 🔍 Debugging

### Enable Developer Mode

Thêm `?debug=1` vào URL hoặc qua Settings > Activate the developer mode

### Logging

```python
import logging
_logger = logging.getLogger(__name__)

_logger.debug('Debug message')
_logger.info('Info message')
_logger.warning('Warning message')
_logger.error('Error message')
```

### Shell Access

```bash
# Python shell với Odoo environment
./odoo-bin shell -d database_name --addons-path=addons
```

## 📦 Deployment

### Production Checklist

- [ ] Sử dụng reverse proxy (Nginx, Apache)
- [ ] Enable SSL/HTTPS
- [ ] Configure proper workers
- [ ] Setup backup strategy
- [ ] Monitor logs và performance
- [ ] Security hardening
- [ ] Configure email server

### Nginx Configuration

```nginx
upstream odoo {
    server 127.0.0.1:8069;
}

server {
    listen 80;
    server_name your-domain.com;
    
    proxy_read_timeout 720s;
    proxy_connect_timeout 720s;
    proxy_send_timeout 720s;
    
    location / {
        proxy_pass http://odoo;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
    
    location ~* /web/static/ {
        proxy_cache_valid 200 90m;
        proxy_buffering on;
        expires 864000;
        proxy_pass http://odoo;
    }
}
```

## 🤝 Đóng góp

Repository này nhằm mục đích chia sẻ kiến thức và tài nguyên về Odoo. Mọi đóng góp đều được hoan nghênh!

### Cách đóng góp

1. Fork repository này
2. Tạo branch mới (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to branch (`git push origin feature/AmazingFeature`)
5. Tạo Pull Request

## 📄 License

Dự án này được phân phối dưới giấy phép MIT. Xem file [LICENSE](LICENSE) để biết thêm chi tiết.

## 📞 Liên hệ & Hỗ trợ

- **GitHub Issues**: [Báo cáo vấn đề](https://github.com/nqdev-group/odoo/issues)
- **GitHub Discussions**: [Thảo luận](https://github.com/nqdev-group/odoo/discussions)

## 🙏 Tài nguyên bổ sung

- [Odoo Community Association (OCA)](https://odoo-community.org/)
- [Odoo Experience Conference](https://www.odoo.com/event)
- [Awesome Odoo](https://github.com/dreispt/awesome-odoo)

---

Made with ❤️ by [nqdev-group](https://github.com/nqdev-group)