import { Shield, UserCheck, Users, CreditCard } from 'lucide-react'
import { type UserStatus } from './schema'

// Status badge colors mapping
export const statusColors = new Map<UserStatus, string>([
  ['ACTIVE', 'bg-teal-100/30 text-teal-900 dark:text-teal-200 border-teal-200'],
  ['INACTIVE', 'bg-neutral-300/40 border-neutral-300'],
  ['INVITED', 'bg-sky-200/40 text-sky-900 dark:text-sky-100 border-sky-300'],
  [
    'SUSPENDED',
    'bg-destructive/10 dark:bg-destructive/50 text-destructive dark:text-primary border-destructive/10'
  ]
])

// User roles with icons
export const roles = [
  {
    label: 'SUPERADMIN',
    value: 'SUPERADMIN',
    icon: Shield
  },
  {
    label: 'ADMIN',
    value: 'ADMIN',
    icon: UserCheck
  },
  {
    label: 'MANAGER',
    value: 'MANAGER',
    icon: Users
  },
  {
    label: 'RECEPTIONIST',
    value: 'RECEPTIONIST',
    icon: CreditCard
  },
  {
    label: 'Client',
    value: 'CLIENT',
    icon: Users
  }
] as const

// Status options
export const statuses = [
  { label: 'Active', value: 'ACTIVE' },
  { label: 'Inactive', value: 'INACTIVE' },
  { label: 'Invited', value: 'INVITED' },
  { label: 'Suspended', value: 'SUSPENDED' }
] as const
