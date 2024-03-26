// 1. MASTER SEC GROUP RULE 

resource "aws_security_group_rule" "etcd-m-2-m" {
  description       = "masterto master etcd traffic"
  security_group_id = aws_security_group.master-sg.id
  source_security_group_id = aws_security_group.master-sg.id
  type              = "ingress"
  from_port         = 2379
  to_port           = 2380
  protocol          = "tcp"
}

resource "aws_security_group_rule" "vxlan-m-2-m" {
  description              = "master to master vxlan traffic"
  security_group_id        = aws_security_group.master-sg.id
  source_security_group_id = aws_security_group.master-sg.id
  type                     = "ingress"
  from_port                = 4789
  to_port                  = 4789
  protocol                 = "udp"
}

resource "aws_security_group_rule" "vxlan-w-2-m" {
  description              = "worker to master vxlan traffic"
  security_group_id        = aws_security_group.master-sg.id
  source_security_group_id = aws_security_group.worker-sg.id
  type                     = "ingress"
  from_port                = 4789
  to_port                  = 4789
  protocol                 = "udp"
}

resource "aws_security_group_rule" "geneve-m-2-m" {
  description              = "master to master geneve traffic"
  security_group_id        = aws_security_group.master-sg.id
  source_security_group_id = aws_security_group.master-sg.id
  type                     = "ingress"
  from_port                = 6081
  to_port                  = 6081
  protocol                 = "udp"
}

resource "aws_security_group_rule" "geneve-w-2-m" {
  description              = "worker to master geneve traffic"
  security_group_id        = aws_security_group.master-sg.id
  source_security_group_id = aws_security_group.worker-sg.id
  type                     = "ingress"
  from_port                = 6081
  to_port                  = 6081
  protocol                 = "udp"
}

resource "aws_security_group_rule" "IpsecIke-m-2-m" {
  description              = "master to master IpsecIke traffic"
  security_group_id        = aws_security_group.master-sg.id
  source_security_group_id = aws_security_group.master-sg.id
  type                     = "ingress"
  from_port                = 500
  to_port                  = 500
  protocol                 = "udp"
}

resource "aws_security_group_rule" "ipsecike-w-2-m" {
  description              = "worker to master IpsecIke traffic"
  security_group_id        = aws_security_group.master-sg.id
  source_security_group_id = aws_security_group.worker-sg.id
  type                     = "ingress"
  from_port                = 500
  to_port                  = 500
  protocol                 = "udp"
}

resource "aws_security_group_rule" "IpsecNat-m-2-m" {
  description              = "master to master IpsecNat traffic"
  security_group_id        = aws_security_group.master-sg.id
  source_security_group_id = aws_security_group.master-sg.id
  type                     = "ingress"
  from_port                = 4500
  to_port                  = 4500
  protocol                 = "udp"
}

resource "aws_security_group_rule" "IpsecNat-w-2-m" {
  description              = "worker to master IpsecNat traffic"
  security_group_id        = aws_security_group.master-sg.id
  source_security_group_id = aws_security_group.worker-sg.id
  type                     = "ingress"
  from_port                = 4500
  to_port                  = 4500
  protocol                 = "udp"
}